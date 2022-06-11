package com.gsnotes.utils.export;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.gsnotes.bo.Module;


public class ExcelExporter {
	private XSSFWorkbook workbook;
	private XSSFSheet sheet;

	private String[] columnNames;
	private String[][] data;
	private String sheetName = "";

	private ArrayList<ArrayList<Integer>> mergedcells;
	private ArrayList<ArrayList<ArrayList<String>>> cellNotesModules;
	private ArrayList<ArrayList<String>> cellMoyenne;
	private ArrayList<ArrayList<String>> cellValidation;
	private ArrayList<String> cellMoyenneGenerale;
	private ArrayList<String> cellRangGeneral;
	
	public ExcelExporter(String[] columnNames, String[][] data, String sheetName,
			ArrayList<ArrayList<Integer>> _mergedcells, ArrayList<ArrayList<ArrayList<String>>> _cellNotesModules,
			ArrayList<ArrayList<String>> _cellMoyenne, ArrayList<ArrayList<String>> _cellValidation,
			ArrayList<String> _cellMoyenneGenerale, ArrayList<String> _cellRangGeneral) {
		this.columnNames = columnNames;
		this.data = data;
		this.sheetName = sheetName;
		this.mergedcells =_mergedcells;
		this.cellNotesModules = _cellNotesModules;
		this.cellMoyenne = _cellMoyenne;
		this.cellValidation = _cellValidation;
		this.cellMoyenneGenerale = _cellMoyenneGenerale;
		this. cellRangGeneral = _cellRangGeneral;

		workbook = new XSSFWorkbook();
  
	}

	private void writeHeaderLine() {
		sheet = workbook.createSheet(sheetName);
		Row row = sheet.createRow(0);
		CellStyle style = workbook.createCellStyle();
		XSSFFont font = workbook.createFont();
		font.setBold(true);
		font.setFontHeight(16);
		style.setFont(font);
		int i = 0;
		for (String it : columnNames) {
			createCell(row, (i++), it, style);
		}
	}

	private void createCell(Row row, int columnCount, Object value, CellStyle style) {
		sheet.autoSizeColumn(columnCount);
		Cell cell = row.createCell(columnCount);
		if (value instanceof Integer) {
			cell.setCellValue((Integer) value);
		} else if (value instanceof Boolean) {
			cell.setCellValue((Boolean) value);
		} else {
			cell.setCellValue((String) value);
		}
		cell.setCellStyle(style);
	}

	private void writeDataLines() {
		int rowCount = 1;

		CellStyle style = workbook.createCellStyle();
		XSSFFont font = workbook.createFont();
		font.setFontHeight(14);
		style.setFont(font);

		for (int i = 0; i < data.length; i++) {
			Row row = sheet.createRow(rowCount++);
			int columnCount = 0;
			for (int j = 0; j < data[i].length; j++) {
				createCell(row, columnCount++, data[i][j], style);
			}
		}
	}

	//Fusionner les cellules pour chaque module
	public void mergeCelles(int firstRow, int lastRow, int firstCol, int lastCol) {
		sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, firstCol, lastCol));
	}
	
   
	// Insertion de: Moyenne de chaque module, Validation pour chaque module, Moyenne générale, Rang
	public void calculMoyenneModules(ArrayList<ArrayList<ArrayList<String>>> cellNotes,
			ArrayList<ArrayList<String>> cellMoyenne, ArrayList<ArrayList<String>> cellValidation, 
		    ArrayList<String> cellMoyenneGenerale, ArrayList<String> cellRangGeneral) {
		
		for(int i = 0; i < cellNotes.size(); i++) {
			for(int j=0; j< (cellNotes.get(i)).size()  ; j++) {
				//Formule de calcul de la moyenne pour chaque module
				String formula = "SUM(";
				for(int s = 0; s < ((cellNotes.get(i)).get(j)).size(); s++) {
					if(s==((cellNotes.get(i)).get(j)).size()-1)
						formula+= "VALUE("+((cellNotes.get(i)).get(j)).get(s)+"))/"+ Integer.toString(((cellNotes.get(i)).get(j)).size());
					else
						formula+= "VALUE("+((cellNotes.get(i)).get(j)).get(s)+")+";	 
				}
				@SuppressWarnings("deprecation")
				CellReference cellReference = new CellReference((cellMoyenne.get(i)).get(j)); 
				Row row = sheet.getRow(cellReference.getRow());
				Cell cell = row.getCell(cellReference.getCol()); 
				cell.setCellFormula(formula);
				
				@SuppressWarnings("deprecation")
				CellReference cellReference1 = new CellReference((cellValidation.get(i)).get(j)); 
				Row row1 = sheet.getRow(cellReference1.getRow());
				Cell cell1 = row1.getCell(cellReference1.getCol()); 
				
				//Formule de validation pour chaque module
				String formula1 = "IF("+(cellMoyenne.get(i)).get(j)+">=12,\"V\",\"NV\")";
				cell1.setCellFormula(formula1);
			}		
		}

		for(int i = 0; i < cellMoyenneGenerale.size(); i++){
			//Formule de calcul pour moyenne générale
			String formulaMoyGen = "SUM(";
			for(int j=0; j< (cellMoyenne.get(i)).size()  ; j++) {
					if(j==(cellMoyenne.get(i)).size()-1)
						formulaMoyGen+= "VALUE("+((cellMoyenne.get(i)).get(j))+"))/"+ Integer.toString(((cellMoyenne.get(i))).size());
					else
						formulaMoyGen+= "VALUE("+((cellMoyenne.get(i)).get(j))+")+";	 
			}
						
			@SuppressWarnings("deprecation")
			CellReference cellReference2 = new CellReference(cellMoyenneGenerale.get(i)); 
			Row row2 = sheet.getRow(cellReference2.getRow());
			Cell cell2 = row2.getCell(cellReference2.getCol()); 
			cell2.setCellFormula(formulaMoyGen);
			
			
			@SuppressWarnings("deprecation")
			CellReference cellReference3 = new CellReference(cellRangGeneral.get(i)); 
			Row row3 = sheet.getRow(cellReference3.getRow());
			Cell cell3 = row3.getCell(cellReference3.getCol()); 
			
			//RANK(A1,A1:A5,0) Rqnking function: Formule de rang
			String formulaRangGen = "RANK("+cellMoyenneGenerale.get(i)+","+cellMoyenneGenerale.get(0)+":"+cellMoyenneGenerale.get(cellMoyenneGenerale.size()-1)+",0)";
			cell3.setCellFormula(formulaRangGen);
			
		}
		
		
		
	}
	
	public void export(HttpServletResponse response) throws IOException {
		writeHeaderLine();
		writeDataLines();

		//
		if(mergedcells!=null) {
			for(ArrayList<Integer> m: mergedcells) {
				mergeCelles(m.get(0),m.get(1),m.get(2),m.get(3));
			}
		}
			
		if(cellNotesModules != null && cellMoyenne!= null) {
			calculMoyenneModules(cellNotesModules, cellMoyenne, cellValidation, cellMoyenneGenerale, cellRangGeneral);
		}
		
		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		workbook.close();

		outputStream.close();

	}
}
