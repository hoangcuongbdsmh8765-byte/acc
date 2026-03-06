package com.fortune.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fortune.entity.ZodiacFortune;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZodiacFortuneMapper extends BaseMapper<ZodiacFortune> {
}
