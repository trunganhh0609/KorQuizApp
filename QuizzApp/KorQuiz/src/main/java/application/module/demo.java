package application.module;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/zxc")
public class demo {
	@RequestMapping("/zxc")
	public Map hello() {
		Map rs = new HashMap<>();
		rs.put("hello", "hello");
		return rs;
	}
	
	
}
