package com.nhatNguyen.Shop.repositories;

import com.nhatNguyen.Shop.entities.Address;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface AddressRepository extends JpaRepository<Address, UUID> {
}
