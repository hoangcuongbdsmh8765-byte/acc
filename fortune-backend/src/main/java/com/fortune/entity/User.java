package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("user")
public class User {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private String avatar;
    private String phone;
    private String email;
    private Integer gender;
    private LocalDate birthday;
    private Integer vipLevel;
    private LocalDateTime vipExpireTime;
    private Integer coinBalance;
    private String role;
    private Integer status;
    private LocalDate lastSignDate;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
