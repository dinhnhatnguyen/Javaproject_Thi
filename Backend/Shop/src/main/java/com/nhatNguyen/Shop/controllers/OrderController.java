package com.nhatNguyen.Shop.controllers;

import com.nhatNguyen.Shop.auth.dto.OrderResponse;
import com.nhatNguyen.Shop.dto.OrderDetails;
import com.nhatNguyen.Shop.dto.OrderRequest;
import com.nhatNguyen.Shop.entities.Order;
import com.nhatNguyen.Shop.services.OrderService;
import org.apache.coyote.BadRequestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/order")
//@CrossOrigin
public class OrderController {


    @Autowired
    OrderService orderService;



    @PostMapping
    public ResponseEntity<?> createOrder(@RequestBody OrderRequest orderRequest, Principal principal) throws Exception {
        OrderResponse orderResponse = orderService.createOrder(orderRequest, principal);
        //return new ResponseEntity<>(order, HttpStatus.CREATED);

        return new ResponseEntity<>(orderResponse, HttpStatus.OK);
    }


    @PostMapping("/update-payment")
    public ResponseEntity<?> updatePaymentStatus(@RequestBody Map<String, String> request) {
        try {
            // Log request để debug
            System.out.println("Received payment update request: " + request);

            String paymentIntent = request.get("paymentIntent");
            String status = request.get("status");

            // Validate input
            if (paymentIntent == null || paymentIntent.trim().isEmpty()) {
                return ResponseEntity.badRequest()
                        .body(Map.of("error", "paymentIntent is required"));
            }

            if (status == null || status.trim().isEmpty()) {
                return ResponseEntity.badRequest()
                        .body(Map.of("error", "status is required"));
            }

            Map<String, String> response = orderService.updateStatus(paymentIntent, status);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            System.err.println("Error processing payment update: " + e.getMessage());
            return ResponseEntity.badRequest()
                    .body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/cancel/{id}")
    public ResponseEntity<?> cancelOrder(@PathVariable UUID id, Principal principal){
        orderService.cancelOrder(id,principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/user")
    public ResponseEntity<List<OrderDetails>> getOrderByUser(Principal principal) {
        List<OrderDetails> orders = orderService.getOrdersByUser(principal.getName());
        return new ResponseEntity<>(orders, HttpStatus.OK);
    }


}