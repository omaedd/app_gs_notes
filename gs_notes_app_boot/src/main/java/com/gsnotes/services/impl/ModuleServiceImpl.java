package com.gsnotes.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.gsnotes.bo.Module;
import com.gsnotes.bo.Niveau;
import com.gsnotes.dao.IModuleDao;
import com.gsnotes.dao.INiveauDao;
import com.gsnotes.services.IModuleService;

@Service
@Transactional
public class ModuleServiceImpl implements IModuleService {

	@Autowired
	private INiveauDao niveauDao;
	
	@Autowired
	private IModuleDao moduleDao;
	
	@Override
	public List<Module> getModulesByNiveau(String niveau) {	
		 Niveau niv =niveauDao.getNiveauByAlias(niveau);
		List<Module> getModulesByNiveau=niv.getModules();		
		return getModulesByNiveau;
	}

	

}
