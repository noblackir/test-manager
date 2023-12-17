package com.example.test_manager.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "type")
public class Type {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "title")
    String title;

    @JsonIgnore
    @OneToMany(mappedBy = "type")
    List<Test> tests;

    @Override
    public String toString() {
        return "Type{" +
                "title='" + title + '\'' +
                '}';
    }
}
