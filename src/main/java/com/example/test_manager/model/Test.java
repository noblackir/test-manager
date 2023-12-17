package com.example.test_manager.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "test")
public class Test {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "title")
    String title;

    @JsonIgnore
    @OneToMany(mappedBy = "test")
    List<Characteristic> characteristics;

    @JsonIgnore
    @OneToMany(mappedBy = "test")
    List<Question> questions;

    @JsonIgnore
    @ManyToMany
    @JoinTable(name = "test_lowuser",
            joinColumns = @JoinColumn(name = "test_id"),
            inverseJoinColumns = @JoinColumn(name = "lowuser_id"))
    List<Lowuser> lowusers;

    @JsonIgnore
    @ManyToMany
    @JoinTable(name = "test_criterion",
            joinColumns = @JoinColumn(name = "test_id"),
            inverseJoinColumns = @JoinColumn(name = "criterion_id"))
    List<Criterion> criterions;


    @ManyToOne
    @JoinColumn(name = "type_id")
    Type type;




}
