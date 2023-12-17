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
@Table(name = "lowuser")
public class Lowuser {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @Column(name = "login")
    String login;
    @Column(name = "role")
    String role;
    @JsonIgnore
    @OneToMany(mappedBy = "lowuser")
    List<Characteristic> characteristics;
    @JsonIgnore
    @ManyToMany(mappedBy = "lowusers")
    List<Test> tests;
}
