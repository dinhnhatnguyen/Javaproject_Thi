package com.nhatNguyen.Shop.auth.repositories;


import com.nhatNguyen.Shop.auth.entities.Authority;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface AuthorityRepository extends JpaRepository<Authority, Long> {


    Authority findByRoleCode(String user);
}
