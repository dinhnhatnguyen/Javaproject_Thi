package com.nhatNguyen.Shop.controllers;

import com.nhatNguyen.Shop.services.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@RestController
@RequestMapping("/api/file")
@CrossOrigin
public class FileUpload {

    @Autowired
    private FileService fileService;

    @PostMapping
    public ResponseEntity<?> uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam("fileName") String fileName) {

        int statusCode = fileService.uploadFile(file, fileName);
        return new ResponseEntity<>(statusCode == 201 ? HttpStatus.CREATED : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}