package com.example.test_manager.service;

import com.example.test_manager.model.Characteristic;
import com.example.test_manager.model.Lowuser;
import com.example.test_manager.model.Test;
import com.example.test_manager.repository.CharacteristicRepository;
import com.example.test_manager.repository.LowuserRepository;
import com.example.test_manager.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class CharacteristicService {
    @Autowired
    private CharacteristicRepository characteristicRepository;
    @Autowired
    private LowuserRepository lowUserRepository;
    @Autowired
    private TestRepository testRepository;
    @Autowired
    private CriterionService criterionService;

    public Characteristic save(Long test_id, String user_login, Map<String, Integer> criterion_score){
        Test test = testRepository.findById(test_id).get();
        Lowuser lowUser = lowUserRepository.findByLogin(user_login);
        Characteristic characteristic = new Characteristic();
        characteristic.setTest(test);
        characteristic.setLowuser(lowUser);
        characteristic.setCriterionScoreMap(criterion_score);
        characteristic.setPassed_date(new Date());

        // Поиск тестов у юзера
        List<Test> tests = lowUser.getTests();
        if (!tests.contains(test)){
            tests.add(test);
            lowUser.setTests(tests);

            // Поиск юзеров в тестах
            List<Lowuser> lowusers = test.getLowusers();
            lowusers.add(lowUser);
            test.setLowusers(lowusers);

            testRepository.save(test);
            lowUserRepository.save(lowUser);
        } else {
            characteristicRepository.deleteByLowuser_loginAndTest_id(lowUser.getLogin(), test_id);
        }
        return characteristicRepository.save(characteristic);
    }

    public Map<String, Integer> getAllCharacteristic(String login){
        List<Characteristic> characteristics = characteristicRepository.findByLowuser_login(login);
        Map<String, Integer> score = new HashMap<>();
        for (Characteristic c : characteristics) {
            Map<String, Integer> nowMap = c.getCriterionScoreMap();
            for (Map.Entry<String, Integer> item : nowMap.entrySet()){
                if (!score.containsKey(item.getKey())){
                    score.put(item.getKey(), item.getValue());
                } else {
                    int newPoints = item.getValue() + score.get(item.getKey());
                    score.put(item.getKey(), newPoints);
                }
            }
        }
        return score;
    }
}
