package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("fortune_record")
public class FortuneRecord {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String fortuneType;
    private String inputParams;
    private String resultContent;
    private Integer isDetailed;
    private LocalDateTime createTime;
}
