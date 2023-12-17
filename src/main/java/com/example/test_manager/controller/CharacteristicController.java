package com.example.test_manager.controller;

import com.example.test_manager.model.Characteristic;
import com.example.test_manager.service.CharacteristicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/characteristic")
public class CharacteristicController {
    @Autowired
    private CharacteristicService characteristicService;

    @PostMapping("/{test_id}")
    public Characteristic save(@PathVariable("test_id") Long test_id,
                                @RequestParam("user_login") String user_login,
                                @RequestBody Map<String, Integer> criterion_score){
         return characteristicService.save(test_id, user_login, criterion_score);
    }

    @GetMapping("/{user_login}")
    public Map<String, Integer> getAllCharacteristics(@PathVariable("user_login") String login){
        return characteristicService.getAllCharacteristic(login);
    }
}
