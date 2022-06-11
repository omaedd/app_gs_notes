package com.gsnotes.services.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.gsnotes.bo.Module;
import com.gsnotes.dao.IInscriptionAnnuelleDao;
import com.gsnotes.dao.IInscriptionMatiereDao;
import com.gsnotes.bo.Element;
import com.gsnotes.bo.Etudiant;
import com.gsnotes.bo.InscriptionAnnuelle;
import com.gsnotes.bo.InscriptionMatiere;
import com.gsnotes.services.IDeliberationService;
import com.gsnotes.services.IEtudiantService;
import com.gsnotes.services.IModuleService;
import com.gsnotes.utils.export.ExcelExporter;

@Service
@Transactional
public class DeliberationServiceImpl implements IDeliberationService {
	
	@Autowired
	private IEtudiantService etudiantService;
	@Autowired
	private IModuleService moduleService;
	@Autowired
	private IInscriptionAnnuelleDao inscriptionAnnuelleDao;
	@Autowired
	private IInscriptionMatiereDao inscriptionMatiereDao;
		
	List<Long> idEtudiants = new ArrayList<Long>();
	List<Long> idInscAnnuellesEnCours = new ArrayList<Long>();
	List<Long> idElements = new ArrayList<Long>();

	private List<Long> getInscriptionEnCours(List<InscriptionAnnuelle> inscips) {
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);

		for(InscriptionAnnuelle ins: inscips) {
			if(ins.getAnnee() == currentYear) {
				idInscAnnuellesEnCours.add(ins.getIdInscription());
			}
		}		
		return idInscAnnuellesEnCours;
	}
	
	public ExcelExporter prepareDeliberationFileExport(String niveau) {
	
		List<Etudiant> etudiants = etudiantService.getEtudiantsByNiveau(niveau);
		List<Module> modules = moduleService.getModulesByNiveau(niveau);
		List<List<Element>> elements = new ArrayList<>();
		
		//Les cellules correspondant à la note de chaque elément d'un module.
		ArrayList<ArrayList<ArrayList<String>>> cellNotesElements = new ArrayList<>();
		
		//Les cellules correspondant à la note de chaque module.
		ArrayList<ArrayList<String>> cellMoyenneElements = new ArrayList<>();
		
		//Les cellules correspondant à la validation de chaque module.
		ArrayList<ArrayList<String>> cellValidation= new ArrayList<>();
		
		//La cellule correspondant à la moyenne générale.
		ArrayList<String> cellMoyenneGenerale = new ArrayList<>();
		
		//La cellule correspondant au rang générale.
		ArrayList<String> cellRangGeneral = new ArrayList<>();

		int colMoyGen =0;
		int colRangGen =0;
		
		int elementsSize=0;
		for(Module mod:modules) {
			elements.add(mod.getElements());	
			//Le nombre d'élement pour chaque module
			elementsSize+=(mod.getElements()).size()+2*(mod.getElements()).size();
		}
		
		String[] columnNames = new String[] {};
		
		String[][] data = new String[5+etudiants.size()][4+elementsSize];
			data[0][0] = "Année Univérsitaire";
			data[0][1] = "2021/2022";
			data[0][2] = "Date Délibération";
			data[0][3] = "22/07/2021";
			data[1][0] = "Classe";
			data[1][1] = niveau;

			data[3][0] = "ID Etudiant";
			data[3][1] = "CNE";
			data[3][2] = "Nom";
			data[3][3] = "Prénom";
			
			//Remplir les infos des étudiants pour chaque ligne
			int i = 5;
			for (Etudiant e : etudiants) {
				data[i][0] = e.getIdUtilisateur().toString();
				data[i][1] = e.getCin();
				data[i][2] = e.getNom();
				data[i][3] = e.getPrenom();
				getInscriptionEnCours(e.getInscriptions());
				i++;

			}
			
			//Remplir les modules pour chaque colonne
			int j=4;
			for(Module m: modules) {
				data[3][j] = m.getTitre();
				j+=m.getElements().size()+2;		 
			}

			data[3][j]="Moyenne";
			data[3][j+1]="Rang";
			colMoyGen = j;
			colRangGen = j+1;
			
			//Remplir les élements de chaque module
			int k=4;
			for(List<Element> el:elements) {
				for(Element e:el) {
					data[4][k]=e.getNom();
					idElements.add(e.getIdMatiere());
					k++;
				}
				data[4][k]="Moyenne";
				data[4][k+1]="Validation";
				k+=2;
			}
			
			//Fusionner les cellules du modules
			int e=4;
			ArrayList<ArrayList<Integer>> MergedCells = new ArrayList<>();
			
			for(Module m: modules) {
				ArrayList<Integer> cm= new ArrayList<>();
				cm.add(4);
				cm.add(4);
				cm.add(e);
				cm.add(e+m.getElements().size()+1);			
				MergedCells.add(cm);
				e+=m.getElements().size()+2;
			}
			
			
			List<InscriptionMatiere> NotesElements = inscriptionMatiereDao.findAll();
			List<ArrayList<Long>> notesParEtudiant= new ArrayList<ArrayList<Long>>();
			
			for(long ins:idInscAnnuellesEnCours) {
				ArrayList<Long> listNotesEtudiant= new ArrayList<Long>();
				for(long elm:idElements) {
					for(InscriptionMatiere mat:NotesElements) {
						
						if(mat.getMatiere().getIdMatiere() == elm && mat.getInscriptionAnnuelle().getIdInscription() == ins) {
							listNotesEtudiant.add((long)mat.getNoteFinale());
						}
					}					
				}
				notesParEtudiant.add(listNotesEtudiant);
			}

			//Remplir les notes de chaque étudiant
			int row=5;
			for(ArrayList<Long> np:notesParEtudiant) {
				int column=4;
				int index =0;
				for(List<Element> el: elements) {
					for(Element em: el) {
						data[row][column]= np.get(index).toString();
						index++;
						column++;
					} 
					column+=2;
				}
				row++;	
			}
           
	         //[[[A1, B1, C1], [F1, G1]], [[A2, B2, C2], [F2, G2]]]
	         //[[D1, H1], [D2, H2]]
			for(int cmp=7; cmp<7+etudiants.size(); cmp++) {
				String[] cols = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
				int column = 4;
				ArrayList EtudAllCellsEelmt = new ArrayList<>();
				ArrayList EtudCellMoyenne = new ArrayList<>();
				ArrayList ModCellValida = new ArrayList<>();

				for(List<Element> el: elements) {
					ArrayList EtudCellsEelmt = new ArrayList<>();
					for(int cp = 0; cp<el.size(); cp++) {
						EtudCellsEelmt.add(cols[column]+cmp); //E7;
						column++;
					} 
					EtudAllCellsEelmt.add(EtudCellsEelmt);
					EtudCellMoyenne.add(cols[column]+cmp);
					ModCellValida.add(cols[column+1]+cmp);

					column+=2;
				}
				cellNotesElements.add(EtudAllCellsEelmt);
				cellMoyenneElements.add(EtudCellMoyenne);
				cellValidation.add(ModCellValida);
				cellMoyenneGenerale.add(cols[colMoyGen]+cmp);
				cellRangGeneral.add(cols[colRangGen]+cmp);

			}
				

			idInscAnnuellesEnCours = new ArrayList<Long>();
			idElements = new ArrayList<Long>();
		    notesParEtudiant= new ArrayList<ArrayList<Long>>();


		  	
		return new ExcelExporter(columnNames, data, "deliberation", MergedCells, cellNotesElements, cellMoyenneElements, cellValidation, cellMoyenneGenerale, cellRangGeneral);
	}
	
	
}
