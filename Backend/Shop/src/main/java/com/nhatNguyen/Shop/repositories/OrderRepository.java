package com.nhatNguyen.Shop.repositories;

import com.nhatNguyen.Shop.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface OrderRepository extends JpaRepository<Order, UUID> {
}
