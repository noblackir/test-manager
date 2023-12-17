package com.example.test_manager.repository;

import com.example.test_manager.model.Type;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeRepository extends CrudRepository<Type, Long> {
    Type findByTitle(String title);
}
