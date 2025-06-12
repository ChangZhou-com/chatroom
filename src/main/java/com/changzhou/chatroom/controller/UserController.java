package com.changzhou.chatroom.controller;

import com.changzhou.chatroom.pojo.Result;
import com.changzhou.chatroom.pojo.User;
import com.changzhou.chatroom.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 用户控制器，处理注册和登录请求
 */
@RestController
@RequestMapping("user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    /**
     * 用户注册接口
     * @param user 用户信息
     * @return 注册结果
     */
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        Result result = new Result();
        boolean isRegistered = userService.register(user);
        if (isRegistered) {
            result.setFlag(true);
            result.setMessage("注册成功");
        } else {
            result.setFlag(false);
            result.setMessage("注册失败，用户名已存在");
        }
        return result;
    }

    /**
     * 用户登录接口
     * @param user 用户信息（只需用户名和密码）
     * @param session HttpSession对象
     * @return 登录结果
     */
    @PostMapping("/login")
    public Result login(@RequestBody User user, HttpSession session) {
        Result result = new Result();
        // 调用服务层登录方法
        User loginUser = userService.login(user.getUsername(), user.getPassword());
        if (loginUser != null) {
            result.setFlag(true);
            result.setMessage("登录成功");
            // 登录成功，将用户名存入Session
            session.setAttribute("user", loginUser.getUsername());
        } else {
            result.setFlag(false);
            result.setMessage("登录失败，用户名或密码错误");
        }
        return result;
    }

    /**
     * 获取当前登录用户名
     * @param session HttpSession对象
     * @return 用户名
     */
    @GetMapping("/getUsername")
    public String getUsername(HttpSession session) {
        return (String) session.getAttribute("user");
    }
}