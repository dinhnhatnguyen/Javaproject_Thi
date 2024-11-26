package com.nhatNguyen.Shop.auth.services;

import com.nhatNguyen.Shop.auth.dto.RegistrationRequest;
import com.nhatNguyen.Shop.auth.dto.RegistrationResponse;
import com.nhatNguyen.Shop.auth.entities.User;
import com.nhatNguyen.Shop.auth.helper.VerificationCodeGenerator;
import com.nhatNguyen.Shop.auth.repositories.UserDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ServerErrorException;

@Service
public class RegistrationService {

    @Autowired
    private UserDetailRepository userDetailRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuthorityService authorityService;

    @Autowired
    private EmailService emailService;

    public RegistrationResponse createUser(RegistrationRequest request) {

        //check email existing
        User existing = userDetailRepository.findByEmail(request.getEmail());

        if (null != existing) {
            return  RegistrationResponse.builder()
                    .code(400)
                    .message("Email alredy exist !")
                    .build();
        }

        try {

            User user = new User();
            user.setEmail(request.getEmail());
            user.setFirstName(request.getFirstName());
            user.setLastName(request.getLastName());
            user.setEnabled(false);
            user.setPassword(passwordEncoder.encode(request.getPassword()));
            user.setProvider("manual");


            String code = VerificationCodeGenerator.generateCode();

            user.setVerificationCode(code);
            user.setAuthorities(authorityService.getUserAuthority());
            userDetailRepository.save(user);

            // Call method to send confirm Email
            emailService.sendMail(user);

            return RegistrationResponse.builder()
                    .code(200)
                    .message("User created!")
                    .build();


        }catch (Exception e) {
            System.out.println(e.getMessage());
            throw new ServerErrorException(e.getMessage(),e.getCause());
        }

    }

    public void verifyUser(String userName) {
        User user= userDetailRepository.findByEmail(userName);
        user.setEnabled(true);
        userDetailRepository.save(user);
    }
}
