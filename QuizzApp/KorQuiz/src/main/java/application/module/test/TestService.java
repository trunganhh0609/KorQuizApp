package application.module.test;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TestService {
	@Autowired
	TestMapper dao;

	public List get() {
		return dao.get();
	}
	public List getCategory(){
		List lstCategory = dao.getCategory();
		return lstCategory;
	}
	public List getResultCurrent(Map<String, Object> id){
		return dao.getResultCurrent(id);
	}
	public Object getUser(Map<String, Object> id){
		return dao.getUser(id);
	}
	public void insertResultTest(Map<String, Object> param){
		dao.insertResultTest(param);
	}
	public void insertQuestion() {
		try {
			for(int j =30;j<1000;j++) {
				Map<String, Object> param = new HashedMap<>();
				param.put("QUESTION_TEXT", "Câu hỏi" + j);
				param.put("QUESTION_TYPE", "WORD");
				dao.insertQuestion(param);			
				//String questionId = (String) param.get("QUESTION_ID");
				
				//Map<String, Object> param = new HashedMap<>();
				for(int i = 1;i<=4;i++) {
					//param.put("QUESTION_ID", param.get("QUESTION_ID"));
					param.put("ANSWER_TEXT", "Trả lời" + i);
					param.put("ANSWER_CORRECT", (i==2)?true:false);
					param.put("ANSWER_ORDINAL", i);
					dao.insertAnswer(param);
					System.out.println("hi");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}

	public List randomTest(Map<String, Object> param) {
		List result = dao.randomTest(param);
		for (int i=0;i< result.size(); i++) {
			HashMap question = new HashMap<>();
			question = (HashMap) result.get(i);
			
			List answers = dao.getAnswerByQuestion(question);
			question.put("ANSWER", answers);
		}
		return result;
	}
	
	public List getAnswerByQuestion(Map<String, Object> param) {
		
		return dao.getAnswerByQuestion(param);
	}

	public void insertDataFromExcel(List questions) {
		try {
			for(int i =0;i<questions.size();i++) {
				Map question =  (Map) questions.get(i);
				dao.insertQuestion(question);
				String[] correctAnswersArr = ((String) question.get("ANSWER")).split("_");
				List<String> correctAnswers = Arrays.asList(correctAnswersArr);
				for(int j=1;j<=4;j++) {
					Map<String, Object> param = new HashedMap<>();
					param.putAll(question);
					String answer = (String) question.get("ANSWER_"+j);
					param.put("ANSWER_TEXT", answer);
					param.put("ANSWER_CORRECT", correctAnswers.contains(j+"")?true:false);
					param.put("ANSWER_ORDINAL", j);
					dao.insertAnswer(param);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
}
