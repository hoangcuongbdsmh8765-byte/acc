package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("zodiac_fortune")
public class ZodiacFortune {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Integer zodiacType;
    private LocalDate fortuneDate;
    private String periodType;
    private Integer overallScore;
    private Integer loveScore;
    private Integer careerScore;
    private Integer wealthScore;
    private Integer healthScore;
    private String loveFortune;
    private String careerFortune;
    private String wealthFortune;
    private String healthFortune;
    private String luckyColor;
    private Integer luckyNumber;
    private String luckyDirection;
    private String summary;
    private LocalDateTime createTime;
}
