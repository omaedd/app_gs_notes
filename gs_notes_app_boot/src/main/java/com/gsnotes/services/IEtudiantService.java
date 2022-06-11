package com.gsnotes.services;

import java.util.List;

import com.gsnotes.bo.Etudiant;

public interface IEtudiantService {
	public List<Etudiant> getEtudiantsByNiveau(String niveau);	
}
