package com.fortune;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.fortune.mapper")
public class FortuneApplication {
    public static void main(String[] args) {
        SpringApplication.run(FortuneApplication.class, args);
    }
}
