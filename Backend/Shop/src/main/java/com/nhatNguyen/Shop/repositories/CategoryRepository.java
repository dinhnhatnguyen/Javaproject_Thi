package com.nhatNguyen.Shop.repositories;

import com.nhatNguyen.Shop.entities.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface CategoryRepository extends JpaRepository<Category, UUID> {
}
