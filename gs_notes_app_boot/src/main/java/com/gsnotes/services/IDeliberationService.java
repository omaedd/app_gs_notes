package com.gsnotes.services;

import com.gsnotes.utils.export.ExcelExporter;

public interface IDeliberationService {
	
	public ExcelExporter prepareDeliberationFileExport(String niveau);

}
