package com.example.test_manager.service;

import com.example.test_manager.model.Answer;
import com.example.test_manager.model.Question;
import com.example.test_manager.model.Test;
import com.example.test_manager.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnswerService {
    @Autowired
    AnswerRepository answerRepository;

    @Autowired
    QuestionRepository questionRepository;

    @Autowired
    CriterionRepository criterionRepository;

//    public List<Answer> getAnswers(String test_name){
//        Question question = testRepository.findByTitle(test_name);
//        return answerRepository.findByTest(test);
//    }

    public Answer save(String answer_text, String criterion_title, Integer criterion_score, String question_text){
        System.out.println(question_text);
        Answer answer = new Answer();
        answer.setText(answer_text);
        answer.setCriterion(criterionRepository.findByTitle(criterion_title));
        answer.setCriterionScore(criterion_score);
        answer.setQuestion(questionRepository.findByText(question_text));
        return answerRepository.save(answer);
    }
}
