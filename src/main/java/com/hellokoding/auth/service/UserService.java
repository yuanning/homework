package com.hellokoding.auth.service;

import com.hellokoding.auth.model.User;
import com.hellokoding.auth.model.UserImage;

public interface UserService {
    void save(User user);

    User findByUsername(String username);

    void insertImageData(UserImage userImage);
}
