package com.hepan.api.service;

import com.hepan.api.entity.AdUser;

public interface AdUserService {
    AdUser login(AdUser user);

    AdUser register(AdUser user);

    AdUser update(AdUser user);
}
