package com.nhatNguyen.Shop.services;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {
    int uploadFile(MultipartFile file, String fileName);
}