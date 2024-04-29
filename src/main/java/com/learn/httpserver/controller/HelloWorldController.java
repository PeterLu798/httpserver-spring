package com.learn.httpserver.controller;

import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {


    public String helloWorld(){
        return "hello world";
    }
}
