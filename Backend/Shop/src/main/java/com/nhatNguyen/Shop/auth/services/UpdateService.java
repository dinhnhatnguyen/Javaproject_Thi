package com.nhatNguyen.Shop.auth.services;

import com.nhatNguyen.Shop.auth.dto.UpdateRequest;
import com.nhatNguyen.Shop.auth.dto.UpdateResponse;
import com.nhatNguyen.Shop.auth.entities.User;
import com.nhatNguyen.Shop.auth.repositories.UserDetailRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateService {

    private final UserDetailRepository userDetailRepository;

    public UpdateService(UserDetailRepository userDetailRepository) {
        this.userDetailRepository = userDetailRepository;
    }

    public UpdateResponse UpdateUser(UpdateRequest updateRequest) {
        User existing = userDetailRepository.findByEmail(updateRequest.getEmail());

        if (existing == null) {
            return UpdateResponse.builder()
                    .code(404)
                    .message("User not found!")
                    .build();
        }

        // Update user information
        existing.setFirstName(updateRequest.getFirstName());
        existing.setLastName(updateRequest.getLastName());
        existing.setPhoneNumber(updateRequest.getPhoneNumber());

        userDetailRepository.save(existing);

        return UpdateResponse.builder()
                .code(200)
                .message("User updated successfully!")
                .build();
    }
}
