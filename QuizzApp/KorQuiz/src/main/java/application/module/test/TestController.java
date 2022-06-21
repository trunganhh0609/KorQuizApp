package application.module.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.namedparam.NamedParameterUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/test")
public class TestController {
	@Autowired
	TestService service;
	
	@RequestMapping("get")
	public ResponseEntity<?> get(){
		
		return ResponseEntity.ok(service.get());
	}
	
	@RequestMapping("insertQuestion")
	public ResponseEntity<?> insertQuestion(){
		service.insertQuestion();
		return ResponseEntity.ok("hello");
	}
	
	@RequestMapping("randomTest")
	public ResponseEntity<?> randomTest(@RequestBody Map params){
		params.size();
		Map<String, Object> param = new HashMap<>();
		param.put("CATEGORY_ID", params.get("CATEGORY_ID"));
		param.put("TEST_TITLE", params.get("TEST_TITLE"));
		param.put("TEST_TYPE", params.get("TEST_TYPE"));
		param.put("TEST_TIME", params.get("TEST_TIME"));
		param.put("TEST_TOTAL_QUESTION", params.get("TEST_TOTAL_QUESTION"));
		
		return ResponseEntity.ok(service.randomTest(param));
	}
	
}
