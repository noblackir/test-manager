package com.example.test_manager.repository;

import com.example.test_manager.model.Question;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends CrudRepository<Question, Long> {
    Question findByText(String text);

    List<Question> findByTest_id(Long id);
}
