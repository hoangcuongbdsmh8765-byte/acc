package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDate;

@Data
@TableName("huangli")
public class Huangli {
    @TableId(type = IdType.AUTO)
    private Long id;
    private LocalDate solarDate;
    private Integer lunarYear;
    private Integer lunarMonth;
    private Integer lunarDay;
    private String lunarDateCn;
    private Integer isLeapMonth;
    private String ganzhiYear;
    private String ganzhiMonth;
    private String ganzhiDay;
    private String zodiacAnimal;
    private String yi;
    private String ji;
    private String chong;
    private String sha;
    private String jishen;
    private String xiongsha;
    private String solarTerm;
}
