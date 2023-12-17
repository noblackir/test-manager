package com.example.test_manager.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "characteristic")
public class Characteristic {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ElementCollection
    @CollectionTable(name = "criterion_score_mapping",
                    joinColumns = {@JoinColumn(name = "characteristic_id", referencedColumnName = "id")})
    @MapKeyColumn(name = "criterion_name")
    @Column(name = "score")
    private Map<String, Integer> criterionScoreMap;

    @Column(name = "passed_date")
    Date passed_date;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "test_id")
    Test test;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "lowuser_id")
    Lowuser lowuser;


}
