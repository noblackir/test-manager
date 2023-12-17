package com.example.test_manager.controller;

import com.example.test_manager.model.Lowuser;
import com.example.test_manager.service.LowuserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/lowUser")
public class LowuserController {
    @Autowired
    private LowuserService lowUserService;
//1
    @PostMapping
    public Lowuser saveLowUser(@RequestBody Lowuser lowUser) {
        return lowUserService.save(lowUser);
    }

    @GetMapping("/{login}")
    public String getUserRole(@PathVariable String login){
        System.out.println(login);
        return lowUserService.getRole(login);
    }



}
