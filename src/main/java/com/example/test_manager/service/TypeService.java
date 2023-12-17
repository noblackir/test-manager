package com.example.test_manager.service;

import com.example.test_manager.model.Type;
import com.example.test_manager.repository.TypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeService {
    @Autowired
    private TypeRepository typeRepository;

    public List<Type> getAll(){
        return (List<Type>) typeRepository.findAll();
    }

    public Type findByTitle(String title){
        return typeRepository.findByTitle(title);
    }
}
