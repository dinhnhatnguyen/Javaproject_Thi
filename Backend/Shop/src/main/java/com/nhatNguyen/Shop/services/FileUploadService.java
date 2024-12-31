package com.nhatNguyen.Shop.services;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FileUploadService implements FileService {

    private static final Logger logger = LoggerFactory.getLogger(FileUploadService.class);

//    @Value("${cloud.aws.bucket.name:nhatnguyenshop}")
    private String bucketName = "titokclonephp";

    private final AmazonS3 amazonS3;

    @Override
    public String uploadFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "File is empty or null");
        }

        try {
            String fileType = StringUtils.getFilenameExtension(file.getOriginalFilename());
            String key = UUID.randomUUID().toString() + "." + fileType;

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(file.getSize());
            metadata.setContentType(file.getContentType());

            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, key, file.getInputStream(), metadata)
                    .withCannedAcl(CannedAccessControlList.PublicRead);

            amazonS3.putObject(putObjectRequest);

            return amazonS3.getUrl(bucketName, key).toString();

        } catch (IOException e) {
            logger.error("Error while reading file content", e);
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Error occurred while reading file content");
        } catch (Exception e) {
            logger.error("Error while uploading file to S3", e);
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Error occurred while uploading file to S3: " + e.getMessage());
        }
    }
}