package com.example.test_manager.repository;

import com.example.test_manager.model.Characteristic;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface CharacteristicRepository extends CrudRepository<Characteristic, Long> {
    List<Characteristic> findByLowuser_login(String login);
    @Transactional
    void deleteByLowuser_loginAndTest_id(String login, Long id);
}
