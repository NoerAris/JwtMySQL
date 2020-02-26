package com.polls;

import java.util.TimeZone;
import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.convert.Jsr310Converters;

@SpringBootApplication
@EntityScan(basePackageClasses = {
		PollsApplication.class,
		Jsr310Converters.class
})
public class PollsApplication {
	
	private static final Logger log = LoggerFactory.getLogger(PollsApplication.class);
	
	@PostConstruct
	void init() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Jakarta"));
	}
	
	public static void main(String[] args) {
		log.info("Application Polls server is started : ");
		SpringApplication.run(PollsApplication.class, args);
	}

}
