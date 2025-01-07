package com.nhatNguyen.Shop.auth.controller;

import com.nhatNguyen.Shop.auth.dto.UpdateRequest;
import com.nhatNguyen.Shop.auth.dto.UpdateResponse;
import com.nhatNguyen.Shop.auth.dto.UserDetailsDto;
import com.nhatNguyen.Shop.auth.entities.User;

import com.nhatNguyen.Shop.auth.services.UpdateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@CrossOrigin
@RestController
@RequestMapping("/api/user")
public class UserDetailController {

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private UpdateService updateService;



    @CrossOrigin(origins = "http://localhost:3000",
            allowedHeaders = "*",
            methods = {RequestMethod.GET, RequestMethod.POST})
    @GetMapping("/profile")
    public ResponseEntity<UserDetailsDto> getUserProfile(Principal principal) {
        User user = (User) userDetailsService.loadUserByUsername(principal.getName());

        if (null == user) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        UserDetailsDto userDetailsDto = UserDetailsDto.builder()
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .id(user.getId())
                .phoneNumber(user.getPhoneNumber())
                .addressList(user.getAddressList())
                .authorityList(user.getAuthorities().toArray()).build();

        return new ResponseEntity<>(userDetailsDto, HttpStatus.OK);

    }


    @PutMapping("/profile")
    public ResponseEntity<UpdateResponse> updateProfile(@RequestBody UpdateRequest updateRequest, Principal principal) {
        User user = (User) userDetailsService.loadUserByUsername(principal.getName());
        if (user == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        updateRequest.setEmail(user.getEmail()); // Ensure we update the correct user
        UpdateResponse response = updateService.UpdateUser(updateRequest);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }


}
