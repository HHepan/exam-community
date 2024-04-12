package com.hepan.api.service;

import com.hepan.api.entity.AdUser;
import com.hepan.api.entity.User;
import com.hepan.api.repository.AdUserRepository;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
public class AdUserServiceImpl implements AdUserService {
    private AdUserRepository adUserRepository;
    AdUserServiceImpl(AdUserRepository adUserRepository) {
        this.adUserRepository = adUserRepository;
    }

    @Override
    public AdUser login(AdUser user) {
        AdUser existUser = this.adUserRepository.findByPhone(user.getPhone());
        if (existUser != null) {
            if (Objects.equals(user.getPassword(), existUser.getPassword())) {
                return existUser;
            } else {
                return new AdUser();
            }
        } else {
            return new AdUser();
        }
    }

    @Override
    public AdUser register(AdUser user) {
        AdUser adUser = new AdUser();
        adUser.setName(user.getName());
        adUser.setPhone(user.getPhone());
        adUser.setPassword(user.getPassword());
        return this.adUserRepository.save(adUser);
    }
}
