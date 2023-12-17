package com.example.test_manager.service;

import com.example.test_manager.model.Criterion;
import com.example.test_manager.model.Test;
import com.example.test_manager.repository.CriterionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CriterionService {
    @Autowired
    private CriterionRepository criterionRepository;

    public Criterion save(Criterion criterion){
        return criterionRepository.save(criterion);
    }
    public List<Criterion> getAllCriterionByTest(Test test){
        return criterionRepository.findByTests(test);
    }
    public List<Criterion> getAllCriterion(){
        return (List<Criterion>) criterionRepository.findAll();
    }
}
