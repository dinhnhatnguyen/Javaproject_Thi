package com.nhatNguyen.Shop.services;

import com.nhatNguyen.Shop.auth.entities.User;
import com.nhatNguyen.Shop.entities.Order;
import com.nhatNguyen.Shop.entities.Payment;
import com.nhatNguyen.Shop.entities.PaymentStatus;
import com.nhatNguyen.Shop.repositories.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class PaymentService {


//    public Map<String, String> createPaymentIntent(Order order) throws StripeException {
//        User user = order.getUser();
//        Map<String, String> metaData = new HashMap<>();
//        metaData.put("orderId",order.getId().toString());
//        PaymentIntentCreateParams paymentIntentCreateParams= PaymentIntentCreateParams.builder()
//                .setAmount((long) (order.getTotalAmount() * 100 * 80)) // USD to INR
//                .setCurrency("inr")//INR currency
//                .putAllMetadata(metaData)
//                .setDescription("Test Payment Project -1")
//                .setAutomaticPaymentMethods(
//                        PaymentIntentCreateParams.AutomaticPaymentMethods.builder().setEnabled(true).build()
//                )
//                .build();
//        PaymentIntent paymentIntent = PaymentIntent.create(paymentIntentCreateParams);
//        Map<String, String> map = new HashMap<>();
//        map.put("client_secret", paymentIntent.getClientSecret());
//        return map;
//    }


//    @Autowired
//    private OrderRepository orderRepository;
//
//    public void savePayment(Order order, String paymentMethod, double amount) {
//        Payment payment = new Payment();
//        payment.setPaymentStatus(PaymentStatus.COMPLETED);
//        payment.setPaymentDate(new Date());
//        payment.setOrder(order);
//        payment.setAmount(amount);
//        payment.setPaymentMethod(paymentMethod);
//        order.setPayment(payment);
//        orderRepository.save(order);
//    }
}
