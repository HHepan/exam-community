package com.hepan.api.controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("flutter")
public class FlutterController {
    @GetMapping("getAll")
    public String getAll() {
        return "connect success";
    }
}
