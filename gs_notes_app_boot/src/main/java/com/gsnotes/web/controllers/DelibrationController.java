package com.gsnotes.web.controllers;


import java.io.Console;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gsnotes.bo.Compte;
import com.gsnotes.bo.Niveau;
import com.gsnotes.bo.UserPrincipal;
import com.gsnotes.bo.Utilisateur;
import com.gsnotes.services.IDeliberationService;
import com.gsnotes.services.INiveauService;
import com.gsnotes.utils.export.ExcelExporter;
import com.gsnotes.web.models.UserAndAccountInfos;


/**
 * 
 * @author Tarik BOUDAA
 *
 */

@Controller
@RequestMapping("/deliberation") // Très important car, dans notre Spring security config les URL qui commencent par ADMIN
							// sont dédiées à l'admin. Toutes les URL dédinies dans ce controleur définissent des
							// fonctionnalités accessibles uniquement à l'administrateur
public class DelibrationController {
	
	@Autowired
	private HttpSession httpSession;


	
	/**
	 * Récupère les données de l'utilisateur connecté du contexte de securité et le
	 * stocke dans un objet personnalisé à enregistrer dans la session http
	 * 
	 * @return
	 */
	private UserAndAccountInfos getUserAccount() {
		// On vérifie si les infors de l'utilisateur sont déjà dans la session
		UserAndAccountInfos userInfo = (UserAndAccountInfos) httpSession.getAttribute("userInfo");

		if (userInfo == null) {

			// On obtient l'objet representant le compte connecté (Objet UserPrincipal
			// implémentant UserDetails)
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

			// On cast vers notre objet UserPrincipal
			Compte userAccount = ((UserPrincipal) principal).getUser();

			Utilisateur u = userAccount.getProprietaire();
			
			String roleName = userAccount.getRole().getNomRole();

			userInfo = new UserAndAccountInfos(u.getIdUtilisateur(), userAccount.getIdCompte(), userAccount.getLogin(),
					u.getNom(), u.getPrenom(), u.getEmail(), roleName);

			// On le stocke dans la session
			httpSession.setAttribute("userInfo", userInfo);
		}

		return userInfo;

	}

	@Autowired
	private INiveauService niveauService; // On obtient par injection automatique le service
	
	@GetMapping("fichierDelib")
	public String fichierDelibPage(Model m) {

		List<Niveau> niveaux = niveauService.getAllNiveaux();
		UserAndAccountInfos infoUser = getUserAccount();
		m.addAttribute("userInfos", infoUser);
       	m.addAttribute("niveaux", niveaux);

		return "deliberation/fichierDelib";

	}
	
	
	@Autowired
	private IDeliberationService deliberationService; // On obtient par injection automatique le service
	
	//export des données du fichier de déliberation
    @RequestMapping(value="exportDeliberationFile",method = RequestMethod.POST)
	public void exportToExcel(HttpServletResponse response, @RequestParam("niveau") String niveau) throws IOException {
		response.setContentType("application/octet-stream");
		DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		String currentDateTime = dateFormatter.format(new Date());

		String headerKey = "Content-Disposition";
		String headerValue = "attachment; filename=deliberation_" + currentDateTime + ".xlsx";
		response.setHeader(headerKey, headerValue);
	    
		ExcelExporter excelExporter = deliberationService.prepareDeliberationFileExport(niveau);

		excelExporter.export(response);
	}

}
