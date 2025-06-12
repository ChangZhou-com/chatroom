package com.changzhou.chatroom.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.changzhou.chatroom.pojo.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    // 可扩展自定义SQL
}
