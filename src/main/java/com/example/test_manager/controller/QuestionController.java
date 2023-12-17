package com.example.test_manager.controller;

import com.example.test_manager.model.Question;
import com.example.test_manager.repository.QuestionRepository;
import com.example.test_manager.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/question")
public class QuestionController {
    @Autowired
    QuestionRepository questionRepository;
    @Autowired
    QuestionService questionService;

    @PostMapping("/{test_name}")
    public Question save(@RequestBody Question question,
                         @PathVariable("test_name") String test_name){
        return questionService.save(question, test_name);
    }

    @GetMapping("/{test_id}")
    public List<Question> findQuestionsFromTest(@PathVariable("test_id") Long id){
        return questionService.findByTest(id);
    }
}
