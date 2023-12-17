package com.example.test_manager.service;

import com.example.test_manager.model.Question;
import com.example.test_manager.model.Test;
import com.example.test_manager.repository.QuestionRepository;
import com.example.test_manager.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionService {
    @Autowired
    QuestionRepository questionRepository;
    @Autowired
    TestRepository testRepository;

    public Question save(Question question, String test_name){
        Test test = testRepository.findByTitle(test_name);
        question.setTest(test);
        return questionRepository.save(question);
    }
    public List<Question> findByTest(Long test_id){
        return questionRepository.findByTest_id(test_id);
    }
}
