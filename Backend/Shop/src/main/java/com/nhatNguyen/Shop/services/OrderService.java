package com.nhatNguyen.Shop.services;

import com.nhatNguyen.Shop.auth.dto.OrderResponse;
import com.nhatNguyen.Shop.auth.entities.User;
import com.nhatNguyen.Shop.dto.OrderDetails;
import com.nhatNguyen.Shop.dto.OrderItemDetail;
import com.nhatNguyen.Shop.dto.OrderRequest;
import com.nhatNguyen.Shop.entities.*;
import com.nhatNguyen.Shop.repositories.OrderRepository;
import jakarta.transaction.Transactional;
import org.apache.coyote.BadRequestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.*;

@Service
public class OrderService {

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    ProductService productService;

    @Transactional
    public OrderResponse createOrder(OrderRequest orderRequest, Principal principal) throws Exception {
        User user = (User) userDetailsService.loadUserByUsername(principal.getName());
        Address address = user.getAddressList().stream().filter(address1 -> orderRequest.getAddressId().equals(address1.getId())).findFirst().orElseThrow(BadRequestException::new);

        Order order= Order.builder()
                .user(user)
                .address(address)
                .totalAmount(orderRequest.getTotalAmount())
                .orderDate(orderRequest.getOrderDate())
                .discount(orderRequest.getDiscount())
                .expectedDeliveryDate(orderRequest.getExpectedDeliveryDate())
                .paymentMethod(orderRequest.getPaymentMethod())
                .orderStatus(OrderStatus.PENDING)
                .build();
        List<OrderItem> orderItems = orderRequest.getOrderItemRequests().stream().map(orderItemRequest -> {
            try {
                Product product= productService.fetchProductById(orderItemRequest.getProductId());
                OrderItem orderItem= OrderItem.builder()
                        .product(product)
                        .productVariantId(orderItemRequest.getProductVariantId())
                        .quantity(orderItemRequest.getQuantity())
                        .order(order)
                        .build();
                return orderItem;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }).toList();

        order.setOrderItemList(orderItems);
        Payment payment=new Payment();
        payment.setPaymentStatus(PaymentStatus.PENDING);
        payment.setPaymentDate(new Date());
        payment.setOrder(order);
        payment.setAmount(order.getTotalAmount());
        payment.setPaymentMethod(order.getPaymentMethod());
        order.setPayment(payment);
        Order savedOrder = orderRepository.save(order);


        OrderResponse orderResponse = OrderResponse.builder()
                .paymentMethod(orderRequest.getPaymentMethod())
                .orderId(savedOrder.getId())
                .build();
        return orderResponse;
    }


    public Map<String, String> updateStatus(String orderId, String status) {
        try {
            // Log để debug
            System.out.println("Updating order status - OrderId: " + orderId + ", Status: " + status);

            // Validate UUID format
            UUID orderUUID;
            try {
                orderUUID = UUID.fromString(orderId);
            } catch (IllegalArgumentException e) {
                throw new IllegalArgumentException("Invalid order ID format");
            }

            // Find order
            Optional<Order> orderOptional = orderRepository.findById(orderUUID);
            if (orderOptional.isEmpty()) {
                throw new IllegalArgumentException("Order not found with ID: " + orderId);
            }

            Order order = orderOptional.get();
            Payment payment = order.getPayment();

            if (status.equalsIgnoreCase("COMPLETED")) {
                payment.setPaymentStatus(PaymentStatus.COMPLETED);
                order.setOrderStatus(OrderStatus.PENDING);
            } else if (status.equalsIgnoreCase("FAILED")) {
                payment.setPaymentStatus(PaymentStatus.FAILED);
                order.setOrderStatus(OrderStatus.CANCELLED);
            } else {
                throw new IllegalArgumentException("Invalid status: " + status);
            }

            orderRepository.save(order);

            Map<String, String> response = new HashMap<>();
            response.put("orderId", order.getId().toString());
            response.put("status", payment.getPaymentStatus().toString());
            return response;
        } catch (Exception e) {
            // Log error details
            System.err.println("Error updating order status: " + e.getMessage());
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    public List<OrderDetails> getOrdersByUser(String name) {
        User user = (User) userDetailsService.loadUserByUsername(name);
        List<Order> orders = orderRepository.findByUser(user);
        return orders.stream().map(order -> {
            return OrderDetails.builder()
                    .id(order.getId())
                    .orderDate(order.getOrderDate())
                    .orderStatus(order.getOrderStatus())
                    .shipmentNumber(order.getShipmentTrackingNumber())
                    .address(order.getAddress())
                    .totalAmount(order.getTotalAmount())
                    .orderItemList(getItemDetails(order.getOrderItemList()))
                    .expectedDeliveryDate(order.getExpectedDeliveryDate())
                    .build();
        }).toList();

    }

    private List<OrderItemDetail> getItemDetails(List<OrderItem> orderItemList) {

        return orderItemList.stream().map(orderItem -> {
            return OrderItemDetail.builder()
                    .id(orderItem.getId())
                    .itemPrice(orderItem.getItemPrice())
                    .product(orderItem.getProduct())
                    .productVariantId(orderItem.getProductVariantId())
                    .quantity(orderItem.getQuantity())
                    .build();
        }).toList();
    }

    public void cancelOrder(UUID id, Principal principal) {
        User user = (User) userDetailsService.loadUserByUsername(principal.getName());
        Order order = orderRepository.findById(id).get();
        if(null != order && order.getUser().getId().equals(user.getId())){
            order.setOrderStatus(OrderStatus.CANCELLED);
            //logic to refund amount
            orderRepository.save(order);
        }
        else{
            new RuntimeException("Invalid request");
        }

    }
}