package com.nhatNguyen.Shop.services;

import com.nhatNguyen.Shop.entities.Order;
import com.nhatNguyen.Shop.entities.Payment;
import com.nhatNguyen.Shop.entities.PaymentStatus;
import com.nhatNguyen.Shop.repositories.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class PaymentService {

    @Autowired
    private OrderRepository orderRepository;

    public Map<String, String> processPayment(Order order, String paymentMethod) {
        Payment payment = new Payment();
        payment.setPaymentStatus(PaymentStatus.COMPLETED);
        payment.setPaymentDate(new Date());
        payment.setOrder(order);
        payment.setAmount(order.getTotalAmount());
        payment.setPaymentMethod(paymentMethod);

        order.setPayment(payment);
        orderRepository.save(order);

        Map<String, String> response = new HashMap<>();
        response.put("orderId", order.getId().toString());
        response.put("status", "Payment Successful");
        return response;
    }
}