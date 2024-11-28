package com.nhatNguyen.Shop.controllers;

import com.nhatNguyen.Shop.auth.dto.OrderResponse;
import com.nhatNguyen.Shop.dto.OrderRequest;
import com.nhatNguyen.Shop.entities.Order;
import com.nhatNguyen.Shop.services.OrderService;
import org.apache.coyote.BadRequestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
@CrossOrigin
public class OrderController {


    @Autowired
    OrderService orderService;



    @PostMapping
    public ResponseEntity<?> createOrder(@RequestBody OrderRequest orderRequest, Principal principal) throws Exception {
//        OrderResponse orderResponse = orderService.createOrder(orderRequest,principal);
        //return new ResponseEntity<>(order, HttpStatus.CREATED);
        Order order = orderService.createOrder(orderRequest, principal);

        return new ResponseEntity<>(order, HttpStatus.OK);
    }



}