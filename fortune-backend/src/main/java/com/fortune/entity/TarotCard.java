package com.fortune.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

@Data
@TableName("tarot_card")
public class TarotCard {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String nameCn;
    private String nameEn;
    private String arcana;
    private String suit;
    private Integer number;
    private String imageUrl;
    private String uprightMeaning;
    private String reversedMeaning;
    private String keywords;
    private String element;
}
