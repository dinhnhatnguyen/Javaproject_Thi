package com.nhatNguyen.Shop.repositories;

import com.nhatNguyen.Shop.auth.entities.User;
import com.nhatNguyen.Shop.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface OrderRepository extends JpaRepository<Order, UUID> {
    List<Order> findByUser(User user);

}
