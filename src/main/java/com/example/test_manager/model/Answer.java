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
@Table(name = "answer")
public class Answer {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @Column(name = "text")
    String text;


    @ManyToOne
    @JoinColumn(name = "criterion_id")
    Criterion criterion;

    @Column(name = "criterion_score")
    Integer criterionScore;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "question_id")
    Question question;
}
