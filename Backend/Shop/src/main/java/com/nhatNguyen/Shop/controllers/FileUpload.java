package com.nhatNguyen.Shop.controllers;

import com.nhatNguyen.Shop.services.FileService;
import com.nhatNguyen.Shop.services.FileUploadService;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/file")
@CrossOrigin
@RequiredArgsConstructor
public class FileUpload {


    @Autowired
    private  FileService fileService;

    @PostMapping
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file) {
        String fileUrl = fileService.uploadFile(file);

        Map<String, String> response = new HashMap<>();
        response.put("url", fileUrl);
        response.put("message", "File uploaded successfully");

        return ResponseEntity.ok(response);
    }
}
