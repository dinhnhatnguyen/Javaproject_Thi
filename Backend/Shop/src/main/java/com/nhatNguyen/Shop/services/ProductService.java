package com.nhatNguyen.Shop.services;

import com.nhatNguyen.Shop.dto.ProductDto;
import com.nhatNguyen.Shop.entities.Product;

import java.util.List;
import java.util.UUID;

public interface ProductService {

    public Product addProduct(ProductDto product);
    public List<ProductDto> getAllProducts(UUID categoryId, UUID typeId);

    ProductDto getProductBySlug(String slug);

    ProductDto getProductById(UUID id);

    Product updateProduct(ProductDto productDto, UUID id);
    void deleteProduct(UUID id);

    Product fetchProductById(UUID productId) throws Exception;
}
