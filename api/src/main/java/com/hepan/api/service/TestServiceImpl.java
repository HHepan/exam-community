package com.hepan.api.service;

import com.hepan.api.entity.Test;
import com.hepan.api.entity.TestAnswerStatus;
import com.hepan.api.repository.TestRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class TestServiceImpl implements TestService {
    private TestRepository testRepository;
    private TestAnswerStatusService testAnswerStatusService;
    TestServiceImpl(TestRepository testRepository,
                    TestAnswerStatusService testAnswerStatusService) {
        this.testRepository = testRepository;
        this.testAnswerStatusService = testAnswerStatusService;
    }

    @Override
    public Test save(Test test) {
        return this.testRepository.save(test);
    }

    @Override
    public Test getById(Long id) {
        return this.testRepository.findById(id).get();
    }

    @Override
    public List<Test> getListByAdUserId(Long id) {
        Iterable<TestAnswerStatus> testAnswerStatusList = this.testAnswerStatusService.getListTestAnswerStatusByAdUserId(id);
        Long testId = 0L;
        List<Test> result = new ArrayList<>();
        // 使用增强的for循环遍历
        for (TestAnswerStatus item : testAnswerStatusList) {
            if (!testId.equals(item.getTest().getId())) {
                result.add(this.testRepository.findById(item.getTest().getId()).get());
                testId = item.getTest().getId();
            }
        }

        Collections.reverse(result);
        return result;
    }
}
