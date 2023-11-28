package com.hellokoding.auth.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.model.UserImage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserImageMapper extends BaseMapper<UserImage> {

    int insertImageFile(UserImage userImage);

    List<UserImage> findByUserId(@Param("userId") int userId);
}
