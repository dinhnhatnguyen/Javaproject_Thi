package com.nhatNguyen.Shop.specification;


import com.nhatNguyen.Shop.entities.Product;
import org.springframework.data.jpa.domain.Specification;

import java.util.UUID;

public class ProductSpecification {

    // Để lấy sản phẩm theo mục (MEN,WOMEN,KIDS)
    public static Specification<Product> hasCategoryId(UUID categorId){
        return  (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("category").get("id"),categorId);
    }

    // Để lấy thông tin sản phẩm theo loại
    public static Specification<Product> hasCategoryTypeId(UUID typeId){
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("categoryType").get("id"),typeId);
    }
}
