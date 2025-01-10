package com.nhatNguyen.Shop.config;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3Client;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;

@Configuration
public class AwsS3Config {

    @Value("${Dcloud.aws.credentials.access-key}")
    private String accessKey ;

    @Value("${Dcloud.aws.credentials.secret-key}")
    private String secretKey;



    @Bean
    public AmazonS3Client amazonS3Client() {

        AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);

        return (AmazonS3Client) AmazonS3Client.builder()
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .withRegion(Regions.AP_SOUTHEAST_2)
                .build();
    }
}
