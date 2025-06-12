-- 建库
CREATE DATABASE IF NOT EXISTS chatroom
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE chatroom;

-- 用户表
CREATE TABLE `user` (
                        `user_id` VARCHAR(36) PRIMARY KEY COMMENT '用户唯一标识',
                        `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名（唯一）',
                        `password` VARCHAR(255) NOT NULL COMMENT '密码（加密存储）',
                        `nickname` VARCHAR(50) NOT NULL COMMENT '用户昵称',
                        `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像URL',
                        `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
                        `gender` TINYINT DEFAULT NULL COMMENT '性别（0-未知 1-男 2-女）',
                        `signature` VARCHAR(255) DEFAULT NULL COMMENT '个性签名',
                        `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 好友关系表
CREATE TABLE `friend` (
                          `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
                          `user_id` VARCHAR(36) NOT NULL COMMENT '用户ID',
                          `friend_id` VARCHAR(36) NOT NULL COMMENT '好友ID',
                          `remark` VARCHAR(50) DEFAULT NULL COMMENT '好友备注',
                          `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '成为好友的时间',
                          FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
                          FOREIGN KEY (`friend_id`) REFERENCES `user`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友关系表';

-- 聊天记录表
CREATE TABLE `message` (
                           `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
                           `sender_id` VARCHAR(36) NOT NULL COMMENT '发送者ID',
                           `receiver_id` VARCHAR(36) DEFAULT NULL COMMENT '接收者ID（私聊时填写）',
                           `group_id` VARCHAR(36) DEFAULT NULL COMMENT '群组ID（群聊时填写）',
                           `content` TEXT NOT NULL COMMENT '消息内容',
                           `msg_type` TINYINT DEFAULT 0 COMMENT '消息类型（0-文本 1-图片 2-文件等）',
                           `send_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
                           FOREIGN KEY (`sender_id`) REFERENCES `user`(`user_id`),
                           FOREIGN KEY (`receiver_id`) REFERENCES `user`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天记录表';

-- 群组表
CREATE TABLE `group` (
                         `group_id` VARCHAR(36) PRIMARY KEY COMMENT '群组唯一标识',
                         `group_name` VARCHAR(50) NOT NULL COMMENT '群组名称',
                         `avatar` VARCHAR(255) DEFAULT NULL COMMENT '群头像',
                         `creator_id` VARCHAR(36) NOT NULL COMMENT '群主ID',
                         `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                         FOREIGN KEY (`creator_id`) REFERENCES `user`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群组表';

-- 群成员表
CREATE TABLE `group_member` (
                                `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
                                `group_id` VARCHAR(36) NOT NULL COMMENT '群组ID',
                                `user_id` VARCHAR(36) NOT NULL COMMENT '用户ID',
                                `join_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
                                `role` TINYINT DEFAULT 0 COMMENT '成员角色（0-普通成员 1-管理员 2-群主）',
                                FOREIGN KEY (`group_id`) REFERENCES `group`(`group_id`),
                                FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群成员表';

-- 好友申请表
CREATE TABLE `friend_request` (
                                  `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
                                  `sender_id` VARCHAR(36) NOT NULL COMMENT '申请人ID',
                                  `receiver_id` VARCHAR(36) NOT NULL COMMENT '接收人ID',
                                  `status` ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending' COMMENT '申请状态',
                                  `request_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
                                  `remark` VARCHAR(100) DEFAULT NULL COMMENT '申请备注',
                                  FOREIGN KEY (`sender_id`) REFERENCES `user`(`user_id`),
                                  FOREIGN KEY (`receiver_id`) REFERENCES `user`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友申请表';
