package com.example.filmevaluate;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@MapperScan("com.example.filmevaluate.mapper")
@SpringBootApplication
public class FilmEvaluateApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(FilmEvaluateApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(FilmEvaluateApplication.class);
    }
}
