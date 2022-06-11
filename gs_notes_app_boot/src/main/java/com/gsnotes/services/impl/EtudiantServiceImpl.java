package com.gsnotes.services.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gsnotes.bo.Etudiant;
import com.gsnotes.bo.InscriptionAnnuelle;
import com.gsnotes.bo.Niveau;
import com.gsnotes.dao.IEtudiantDao;
import com.gsnotes.dao.INiveauDao;
import com.gsnotes.services.IEtudiantService;
import com.gsnotes.services.INiveauService;

@Service
@Transactional
public class EtudiantServiceImpl implements IEtudiantService {

	@Autowired
	private IEtudiantDao etudiantDao;
	
	@Override
	public List<Etudiant> getEtudiantsByNiveau(String niveau) {
		List<Etudiant> listAllEtudiant= etudiantDao.findAll();
		List<Etudiant> listEtudiantByNiveau = new ArrayList<Etudiant>();
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		for(Etudiant e : listAllEtudiant) {
			boolean addEtudiant = false;
			List<InscriptionAnnuelle> inscp = e.getInscriptions();
			for(InscriptionAnnuelle i: inscp) {
				
				if(i.getAnnee() == currentYear && i.getNiveau().getAlias().equals(niveau)) {
				
					addEtudiant = true;
				}			
			}
			if(addEtudiant) {
				listEtudiantByNiveau.add(e);
			}
		}
		return listEtudiantByNiveau;
	}

}
