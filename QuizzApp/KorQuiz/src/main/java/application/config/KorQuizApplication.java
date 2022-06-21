package application.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan(value = "application.module")
@ComponentScan(basePackages="application")
public class KorQuizApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(KorQuizApplication.class, args);
		
	}

}
