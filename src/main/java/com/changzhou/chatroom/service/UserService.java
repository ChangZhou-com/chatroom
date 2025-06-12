package com.changzhou.chatroom.service;

import com.changzhou.chatroom.pojo.User;

/**
 * 用户服务接口，定义注册和登录方法
 */
public interface UserService {
    /**
     * 用户注册
     * @param user 用户信息
     * @return 注册是否成功
     */
    boolean register(User user);

    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return 登录成功返回用户对象，否则返回null
     */
    User login(String username, String password);
}
