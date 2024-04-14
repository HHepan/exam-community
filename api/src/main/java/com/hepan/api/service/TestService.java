package com.hepan.api.service;

import com.hepan.api.entity.Exam;
import com.hepan.api.entity.Test;

public interface TestService {
    Test save(Test test);

    Test getById(Long id);
}
