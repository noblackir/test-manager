package com.example.test_manager.repository;

import com.example.test_manager.model.Criterion;
import com.example.test_manager.model.Test;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CriterionRepository extends CrudRepository<Criterion, Long> {
    Criterion findByTitle(String title);
    List<Criterion> findByTests(Test tests);
}
