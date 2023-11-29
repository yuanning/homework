package com.hellokoding.auth.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.model.UserImage;
import com.hellokoding.auth.model.UserVideo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserImageMapper extends BaseMapper<UserImage> {

    int insertImageFile(UserImage userImage);

    List<UserImage> findByUserId(@Param("userId") int userId);

    @Delete("DELETE FROM user_images WHERE id = #{imageId} AND user_id = #{userId}")
    void deleteImage(@Param("imageId") int imageId, @Param("userId") int userId);

    int insertVideoFile(UserVideo userVideo);

    List<UserVideo> findVideoByUserId(@Param("userId") int userId);

    @Delete("DELETE FROM user_videos WHERE id = #{videoId} AND user_id = #{userId}")
    void deleteVideo(@Param("videoId") int videoId, @Param("userId") int userId);

}
