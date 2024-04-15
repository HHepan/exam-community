package com.hepan.api.service;

import com.hepan.api.entity.Exam;
import com.hepan.api.entity.Test;

import java.util.List;

public interface TestService {
    Test save(Test test);

    Test getById(Long id);

    List<Test> getListByAdUserId(Long id);
}
