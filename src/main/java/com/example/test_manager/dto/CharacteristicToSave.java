package com.example.test_manager.dto;

import com.example.test_manager.model.Characteristic;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CharacteristicToSave {

    Characteristic characteristic;

    String login;

    String test_name;
}
