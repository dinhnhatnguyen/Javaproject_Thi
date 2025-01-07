package com.nhatNguyen.Shop.services;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class FileUploadService implements FileService {

    @Autowired
    private final AmazonS3 amazonS3;
    private static final Logger logger = LoggerFactory.getLogger(FileUploadService.class);

    private String bucketName = "titokclonephp";

    @Override
    public int uploadFile(MultipartFile file, String fileName) {
        if (file == null || file.isEmpty()) {
            return 500;
        }

        try {
            String key = "products/" + fileName;

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(file.getSize());
            metadata.setContentType(file.getContentType());

            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, key, file.getInputStream(), metadata)
                    .withCannedAcl(CannedAccessControlList.PublicRead);

            amazonS3.putObject(putObjectRequest);

            // If upload is successful, return 201 (Created)
            return 201;

        } catch (Exception e) {
            logger.error("Error while uploading file to S3", e);
            return 500;
        }
    }
}