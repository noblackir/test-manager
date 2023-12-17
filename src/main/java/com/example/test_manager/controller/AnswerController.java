package com.example.test_manager.controller;

import com.example.test_manager.model.Answer;
import com.example.test_manager.service.AnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/answer")
public class AnswerController {
    @Autowired
    AnswerService answerService;

    @PostMapping
    public Answer save(@RequestParam("answer_text") String answer_text,
                       @RequestParam("criterion_title") String criterion_title,
                       @RequestParam("criterion_score") Integer criterion_score,
                       @RequestBody String question_text){
        return answerService.save(answer_text, criterion_title, criterion_score, question_text);
    }
}
