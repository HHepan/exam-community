package com.hepan.api.service;

import com.hepan.api.entity.TestAnswerStatus;

import java.util.List;

public interface TestAnswerStatusService {
    void save(List<TestAnswerStatus> testAnswerStatusList);
    Iterable<TestAnswerStatus> getListTestAnswerStatusByAdUserId(Long adUserId);

    Iterable<TestAnswerStatus> getTestAnswerStatusListByTestId(Long id);

    String answerBaiduApi(String stem, String correctAnswer, String answer);
}
