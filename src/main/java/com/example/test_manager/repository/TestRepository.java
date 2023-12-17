package com.example.test_manager.repository;

import com.example.test_manager.model.Test;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TestRepository extends CrudRepository<Test, Long> {

    Test findByTitle(String title);

}
