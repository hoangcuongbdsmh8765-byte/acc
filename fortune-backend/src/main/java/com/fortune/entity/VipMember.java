package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("vip_member")
public class VipMember {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Integer level;
    private String planType;
    private LocalDateTime startTime;
    private LocalDateTime expireTime;
    private LocalDateTime createTime;
}
