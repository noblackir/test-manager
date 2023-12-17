package com.example.test_manager.service;

import com.example.test_manager.model.Characteristic;
import com.example.test_manager.model.Criterion;
import com.example.test_manager.model.Test;
import com.example.test_manager.model.Type;
import com.example.test_manager.repository.CharacteristicRepository;
import com.example.test_manager.repository.CriterionRepository;
import com.example.test_manager.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TestService {
    @Autowired
    private TestRepository testRepository;
    @Autowired
    private TypeService typeService;

    @Autowired
    private CharacteristicRepository characteristicRepository;
    @Autowired
    private CriterionRepository criterionRepository;

    public Test save(Test test){
        return testRepository.save(test);
    }

    public Test addCriterion(String test_name, String criterion_name){
        Test test = testRepository.findByTitle(test_name);
        Criterion criterion = criterionRepository.findByTitle(criterion_name);
        List<Criterion> criterionList = new ArrayList<>();
        criterionList.add(criterion);
        if (test.getCriterions().isEmpty()){
            test.setCriterions(criterionList);
        } else {
            List<Criterion> newList = test.getCriterions();
            newList.add(criterion);
            test.setCriterions(newList);
        }
        return testRepository.save(test);
    }

    public Test findByTitle(String title){
        return testRepository.findByTitle(title);
    }

    public Test addType(String test_name, String type_name){
        Test test = testRepository.findByTitle(test_name);
        Type type = typeService.findByTitle(type_name);
        test.setType(type);
        return testRepository.save(test);
    }

    public List<Test> findAll(){
        List<Test> tests = (List<Test>) testRepository.findAll();
        return tests;
    }

    public Test findById(Long id){
        return testRepository.findById(id).get();
    }
}
