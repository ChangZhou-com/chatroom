package com.changzhou.chatroom.utils;

import com.alibaba.fastjson.JSON;
import com.changzhou.chatroom.ws.pojo.ResultMessage;


public class MessageUtils {

    public static String getMessage(boolean isSystemMessage,String fromName, Object message) {

        ResultMessage result = new ResultMessage();
        result.setSystem(isSystemMessage);
        result.setMessage(message);
        if(fromName != null) {
            result.setFromName(fromName);
        }
        return JSON.toJSONString(result);
    }
}
