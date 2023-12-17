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
@Table(name = "criterion")
public class Criterion {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "title")
    String title;

    @JsonIgnore
    @ManyToMany(mappedBy = "criterions")
    List<Test> tests;

    @JsonIgnore
    @OneToMany(mappedBy = "criterion")
    List<Answer> answers;
}
