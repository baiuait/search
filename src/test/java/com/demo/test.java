package com.demo;

import com.baiuait.search.entity.User;
import com.baiuait.search.service.UserService;
import com.baiuait.search.service.UserServiceImpl;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.annotation.Resource;
import java.util.Arrays;

public class test {
//    @Resource
//    private static UserService userService;
    @Test
    public void test(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("classpath*:applicationContext-*.xml");
        UserService userService = applicationContext.getBean( UserService.class);
        User user = userService.getUserByUserName("baiuait");
        System.out.println(user);
        System.out.println(Arrays.toString(applicationContext.getBeanDefinitionNames()));
    }

    /*public static void main(String[] args) {
        User user = userService.getUserByUserName("baiuait");
        System.out.println(user);
    }*/
}
