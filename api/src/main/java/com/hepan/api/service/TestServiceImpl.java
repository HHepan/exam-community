package com.hepan.api.service;

import com.hepan.api.entity.Test;
import com.hepan.api.repository.TestRepository;
import org.springframework.stereotype.Service;

@Service
public class TestServiceImpl implements TestService {
    private TestRepository testRepository;
    TestServiceImpl(TestRepository testRepository) {
        this.testRepository = testRepository;
    }

    @Override
    public Test save(Test test) {
        return this.testRepository.save(test);
    }
}
