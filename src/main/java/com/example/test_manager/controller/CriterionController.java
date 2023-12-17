package com.example.test_manager.controller;

import com.example.test_manager.model.Criterion;
import com.example.test_manager.service.CriterionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/criterion")
public class CriterionController {

    @Autowired
    private CriterionService criterionService;

    @PostMapping
    public Criterion save(@RequestBody Criterion criterion){
        return criterionService.save(criterion);
    }

    @GetMapping
    public List<Criterion> getAll(){
        return criterionService.getAllCriterion();
    }

}
