package com.nhatNguyen.Shop.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "products")
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Product {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private String name;

    @Column
    private String description;

    @Column(nullable = false)
    private BigDecimal price;

    @Column(nullable = false)
    private String brand;

    @Column(nullable = false)
    private boolean isNewArrival;

    @Column(nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date createdAt;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date updatedAt;

    // CascadeType.all có nghĩa là tất cả các hành động thực hiện
    // trên thực thể hiện tại (như persist, merge, remove, v.v.)
    // cũng sẽ được áp dụng lên các thực thể liên quan.
    @OneToMany(mappedBy = "product",cascade = CascadeType.ALL)
    private List<ProductVariant> productVariants;


    @PrePersist
    protected void onCreate() {
        createdAt = new java.util.Date();
        updatedAt = createdAt;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = new java.util.Date();
    }


}
