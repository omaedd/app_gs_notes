package com.gsnotes.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gsnotes.bo.Etudiant;

public interface IEtudiantDao extends JpaRepository<Etudiant, Long> {
  
//public List<Etudiant> getEtudiantByNiveau(String niveau);

}

