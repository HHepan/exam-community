package com.hepan.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hepan.api.entity.AdUser;
import com.hepan.api.entity.User;
import com.hepan.api.service.AdUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("ad-user")
public class AdUserController {
    private AdUserService adUserService;
    @Autowired
    AdUserController(AdUserService adUserService) {
        this.adUserService = adUserService;
    }

    /**
     * 登陆
     *
     * @param user 安卓用户数据
     * @return 安卓用户
     */
    @PostMapping("login")
    @JsonView(AdLoginJsonView.class)
    public AdUser adLogin(@RequestBody AdUser user) {
        return this.adUserService.login(user);
    }

    /**
     * 注册
     *
     * @param user 安卓用户数据
     * @return 安卓用户
     */
    @PostMapping("register")
    @ResponseStatus(HttpStatus.CREATED)
    public AdUser register(@RequestBody AdUser user) {
        return this.adUserService.register(user);
    }

    private interface AdLoginJsonView extends
            AdUser.IdJsonView,
            AdUser.PhoneJsonView,
            AdUser.PasswordJsonView
    {}
}
