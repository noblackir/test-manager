package com.example.test_manager.repository;

import com.example.test_manager.model.Lowuser;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LowuserRepository extends CrudRepository<Lowuser, Long> {

    Lowuser findByLogin(String login);

}
