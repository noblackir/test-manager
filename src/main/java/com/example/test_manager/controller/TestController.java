package com.example.test_manager.controller;

import com.example.test_manager.model.Criterion;
import com.example.test_manager.model.Test;
import com.example.test_manager.model.Type;
import com.example.test_manager.repository.TestRepository;
import com.example.test_manager.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/test")
public class TestController{
    @Autowired
    private TestService testService;

    @PostMapping
    public Test saveTest(@RequestBody Test test){
        return testService.save(test);
    }

    @PostMapping("/{test_name}/{criterion_name}")
    public Test addCriterionToTest(@PathVariable("criterion_name") String criterion_name,
                                   @PathVariable("test_name") String test_name){
        return testService.addCriterion(test_name, criterion_name);
    }

    @PostMapping("/{test_name}/type/{type_title}")
    public Test addTypeToTest(@PathVariable("type_title") String type_title,
                              @PathVariable("test_name") String test_name) {
        return testService.addType(test_name, type_title);
    }

    @GetMapping("/{test_id}")
    public List<Criterion> getCriterionFromTest(@PathVariable("test_id") Long test_id){
        return testService.findById(test_id).getCriterions();
    }

    @GetMapping("/criteria/{test_name}")
    public List<Criterion> getCriterionFromTest(@PathVariable("test_name") String test_name){
        return testService.findByTitle(test_name).getCriterions();
    }

    @GetMapping
    public List<Test> getAllTests(){
        return testService.findAll();
    }

    @GetMapping("/pass/{test_id}")
    public Test findTest(@PathVariable("test_id") Long id){
        return testService.findById(id);
    }
}
