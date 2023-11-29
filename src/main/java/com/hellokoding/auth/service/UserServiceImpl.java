package com.hellokoding.auth.service;

import com.hellokoding.auth.mapper.UserImageMapper;
import com.hellokoding.auth.mapper.UserMapper;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.model.UserImage;
import com.hellokoding.auth.model.UserVideo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserImageMapper userImageMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        user.setEmail("default@example.com");
        userMapper.insert(user);
    }

    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public void insertImageData(UserImage userImage) {
        userImage.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        userImageMapper.insertImageFile(userImage);
    }

    @Override
    public void insertVideoData(UserVideo userVideo) {
        userVideo.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        userImageMapper.insertVideoFile(userVideo);
    }
}
