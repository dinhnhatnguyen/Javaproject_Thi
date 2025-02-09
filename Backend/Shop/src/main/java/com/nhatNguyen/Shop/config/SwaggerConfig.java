package com.nhatNguyen.Shop.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI customOpenAPI(){
        return new OpenAPI()
                .info(new Info().title("NhatNguyenShop API's").description("NhatNguyenShop E-commerce Application APIs")
                        .version("1.0")
                        .contact(new Contact()
                                .name("The CodeReveal")));
    }
}


// Link test API :  http://localhost:8080/swagger-ui/index.html#/