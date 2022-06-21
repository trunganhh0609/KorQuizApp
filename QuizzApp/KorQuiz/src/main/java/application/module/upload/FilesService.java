package application.module.upload;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import application.module.test.TestService;

@Service
@Transactional
public class FilesService {
	@Autowired
	TestService testService;
	
	public void ReadExceln(MultipartFile file) {
		List questions = new ArrayList<>();
		try {
			InputStream is = file.getInputStream();
			 // Khởi tạo workbook cho tệp xlsx 
			HSSFWorkbook workbook = new HSSFWorkbook(is);
            // Lấy worksheet đầu tiên trong workbook
            HSSFSheet sheet = workbook.getSheetAt(0);
            // Create a DataFormatter to format and get each cell's value as String
            DataFormatter dataFormatter = new DataFormatter();
            // Duyệt qua từng row
            Iterator<Row> rowIterator = sheet.iterator();
            int currentcellIndex=0;
            while (rowIterator.hasNext()) {
            	Map question = new HashMap<>();
                Row row = rowIterator.next();
                if(row.getRowNum()==0){
         		   continue; //just skip the rows if row number is 0
         		}
                // For each row, iterate through all the columns
                Iterator<Cell> cellIterator = row.cellIterator();
                currentcellIndex=0;
                while (cellIterator.hasNext()) {
                	Cell cell = cellIterator.next();
                    String cellValue = dataFormatter.formatCellValue(cell);

                    String colName = cell.getSheet().getRow(0).getCell(currentcellIndex).getRichStringCellValue().toString();
                    
                    
                    if(colName.equals("Question Text")) {
                    	question.put("QUESTION_TEXT", cellValue);
                    }
                    if(colName.equals("Answer1")) {
                    	question.put("ANSWER1", cellValue);
                    }
                    if(colName.equals("Answer2")) {
                    	question.put("ANSWER2", cellValue);
                    }
                    if(colName.equals("Answer3")) {
                    	question.put("ANSWER3", cellValue);
                    }
                    if(colName.equals("Answer4")) {
                    	question.put("ANSWER4", cellValue);
                    }
                    if(colName.equals("Answer")) {
                    	question.put("ANSWER", cellValue);
                    }
                    currentcellIndex++;
                }
                questions.add(question);
            }
            testService.insertDataFromExcel(questions);
            is.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException("fail to parse Excel file: " + e.getMessage());
		}
	}
	
	public void ReadExcel(MultipartFile file) {
		List<Map> questions = new ArrayList<>();
		try {
			InputStream is = file.getInputStream();
			 // Khởi tạo workbook cho tệp xlsx 
			HSSFWorkbook workbook = new HSSFWorkbook(is);
            // Lấy worksheet đầu tiên trong workbook
            HSSFSheet sheet = workbook.getSheetAt(0);
            // Create a DataFormatter to format and get each cell's value as String
            DataFormatter dataFormatter = new DataFormatter();
            boolean skipHeader = true;

			for (Row row : sheet) {
				if (skipHeader) {
					skipHeader = false;
					continue;
				}

				List<Cell> cells = new ArrayList<Cell>();

				int lastColumn = Math.max(row.getLastCellNum(), 21);// because my
																	// excel
																	// sheet has
																	// max 5
																	// columns,
																	// in case
																	// last
																	// column is
																	// empty
																	// then
																	// row.getLastCellNum()
																	// will
																	// return 4
				for (int cn = 0; cn < lastColumn; cn++) {
					Cell c = row.getCell(cn, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
					cells.add(c);
				}
				
                questions.add(extractInfoFromCell(cells));
            }
            testService.insertDataFromExcel(questions);
            is.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException("fail to parse Excel file: " + e.getMessage());
		}
	}
	
	private static Map extractInfoFromCell(List<Cell> cells) {
		Map<String, String> question = new HashMap<>();

		Cell cell = cells.get(2);
		question.put("QUESTION_TEXT", getCellValue(cell));
		cell = cells.get(0);
		question.put("QUESTION_TYPE", getCellValue(cell));
		cell = cells.get(3);
		question.put("ANSWER_1", getCellValue(cell));
		cell = cells.get(5);
		question.put("ANSWER_2", getCellValue(cell));
		cell = cells.get(7);
		question.put("ANSWER_3", getCellValue(cell));
		cell = cells.get(9);
		question.put("ANSWER_4", getCellValue(cell));
		cell = cells.get(19);
		question.put("ANSWER", getCellValue(cell));

		return question;
	}
	
	public static String getCellValue(Cell cell) {
		if (cell != null) {
			switch (cell.getCellTypeEnum()) {
			case STRING: 
				return cell.getStringCellValue();
			case NUMERIC:
				return NumberToTextConverter.toText(cell.getNumericCellValue());
			case BLANK:
				return "";
			default:
				break;
			}
		}
		return "";
	}
}
