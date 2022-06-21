package application.module.test;

import java.util.List;
import java.util.Map;

public interface TestMapper {
	List get();
	void insertAnswer(Map<String, Object> param);
	void insertQuestion(Map<String, Object> param);
	List randomTest(Map<String, Object> param);
	List getAnswerByQuestion(Map<String, Object> param);
}
