package com.st;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan(basePackages = "com.st.dao")
@EnableTransactionManagement
@ServletComponentScan
public class Boot4Application {

	public static void main(String[] args) {
		SpringApplication.run(Boot4Application.class, args);
	}

}
