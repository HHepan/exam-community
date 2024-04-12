package com.hepan.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hepan.api.entity.AdUser;
import com.hepan.api.service.AdUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
     * @param user 用户数据
     * @return 用户
     */
    @PostMapping("login")
    @JsonView(AdLoginJsonView.class)
    public AdUser adLogin(@RequestBody AdUser user) {
        return this.adUserService.login(user);
    }

    private interface AdLoginJsonView extends
            AdUser.IdJsonView,
            AdUser.PhoneJsonView,
            AdUser.PasswordJsonView
    {}
}
