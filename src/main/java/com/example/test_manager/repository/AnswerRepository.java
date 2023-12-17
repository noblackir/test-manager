package com.example.test_manager.repository;

import com.example.test_manager.model.Answer;
import com.example.test_manager.model.Question;
import com.example.test_manager.model.Test;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerRepository extends CrudRepository<Answer, Long> {
    List<Answer> findByQuestion(Question question);
}
