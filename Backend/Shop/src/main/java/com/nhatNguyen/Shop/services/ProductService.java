package com.nhatNguyen.Shop.services;

import com.nhatNguyen.Shop.dto.ProductDto;
import com.nhatNguyen.Shop.entities.Product;

import java.util.List;
import java.util.UUID;

public interface ProductService {
    public Product addProduct(ProductDto product);
    public List<Product> getAllProducts(UUID categoryId, UUID typeId);
}
