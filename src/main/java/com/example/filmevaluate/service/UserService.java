package com.example.filmevaluate.service;

import com.example.filmevaluate.entity.User;

public interface UserService {
    User register(String username, String password);

    User login(String username, String password);
}
