package com.changzhou.chatroom.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.changzhou.chatroom.mapper.UserMapper;
import com.changzhou.chatroom.pojo.User;
import com.changzhou.chatroom.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

/**
 * 用户服务实现类
 */
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserMapper userMapper;

    /**
     * 用户注册
     * @param user 用户信息
     * @return 注册是否成功
     */
    @Override
    public boolean register(User user) {
        // 检查用户名是否已存在
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", user.getUsername());
        if (userMapper.selectOne(wrapper) != null) {
            return false;
        }
        // 生成唯一用户ID
        user.setUserId(UUID.randomUUID().toString());
        // 明文存储密码（不推荐，仅为演示）
        return userMapper.insert(user) > 0;
    }

    /**
     * 用户登录
     * @param username 用户名
     * @param password 明文密码
     * @return 登录成功返回用户对象，否则返回null
     */
    @Override
    public User login(String username, String password) {
        // 查询用户
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username);
        User user = userMapper.selectOne(wrapper);
        // 校验明文密码
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }
}