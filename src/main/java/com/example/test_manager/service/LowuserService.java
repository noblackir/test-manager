package com.example.test_manager.service;

import com.example.test_manager.model.Lowuser;
import com.example.test_manager.repository.LowuserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LowuserService {
    @Autowired
    private LowuserRepository lowUserRepository;

    public Lowuser save(Lowuser lowUser){
        lowUser.setRole("USER");
        return lowUserRepository.save(lowUser);
    }

    public String getRole(String login){
        return lowUserRepository.findByLogin(login).getRole();
    }
}
