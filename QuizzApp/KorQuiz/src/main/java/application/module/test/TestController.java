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
	@RequestMapping("getUser")
	public ResponseEntity<?> getUser(@RequestBody Map param){

		return ResponseEntity.ok(service.getUser(param));
	}
	@RequestMapping("insertQuestion")
	public ResponseEntity<?> insertQuestion(){
		service.insertQuestion();
		return ResponseEntity.ok("hello");
	}

	@RequestMapping("randomTest")
	public ResponseEntity<?> randomTest(@RequestBody Map params){
		params.size();
		return ResponseEntity.ok(service.randomTest(params));
	}

	@RequestMapping("category")
	public ResponseEntity<?> getCategory(){
		return ResponseEntity.ok(service.getCategory());
	}
	@RequestMapping("insertResultTest")
	public ResponseEntity<?> insertResultTest(@RequestBody Map param){
		service.insertResultTest(param);
		return ResponseEntity.ok("ok");
	}

	@RequestMapping("resultCurrent")
	public ResponseEntity<?> getResultCurrent(@RequestBody Map param){
		return ResponseEntity.ok(service.getResultCurrent(param));
	}
}
