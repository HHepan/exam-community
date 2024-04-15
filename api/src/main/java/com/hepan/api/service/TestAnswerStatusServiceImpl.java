package com.hepan.api.service;

import com.hepan.api.entity.AdUser;
import com.hepan.api.entity.Test;
import com.hepan.api.entity.TestAnswerStatus;
import com.hepan.api.repository.TestAnswerStatusRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestAnswerStatusServiceImpl implements TestAnswerStatusService {
    private TestAnswerStatusRepository testAnswerStatusRepository;
    TestAnswerStatusServiceImpl(TestAnswerStatusRepository testAnswerStatusRepository) {
        this.testAnswerStatusRepository = testAnswerStatusRepository;
    }

    @Override
    public void save(List<TestAnswerStatus> testAnswerStatusList) {
        this.testAnswerStatusRepository.saveAll(testAnswerStatusList);
    }

    @Override
    public Iterable<TestAnswerStatus> getListTestAnswerStatusByAdUserId(Long adUserId) {
        return this.testAnswerStatusRepository.findAllByAdUserId(adUserId);
    }

    @Override
    public Iterable<TestAnswerStatus> getTestAnswerStatusListByTestId(Long id) {
        return this.testAnswerStatusRepository.findAllByTestId(id);
    }
}
