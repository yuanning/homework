package com.hellokoding.auth.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hellokoding.auth.model.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {

    User findByUsername(String username);
}
