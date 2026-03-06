package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

@Data
@TableName("dream_dict")
public class DreamDict {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String keyword;
    private String category;
    private String interpretation;
    private Integer goodBad;
}
