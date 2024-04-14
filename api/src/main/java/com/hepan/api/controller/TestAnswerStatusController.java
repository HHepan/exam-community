package com.hepan.api.controller;

import com.hepan.api.entity.AnswerStatus;
import com.hepan.api.entity.TestAnswerStatus;
import com.hepan.api.service.TestAnswerStatusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("test-answer-status")
public class TestAnswerStatusController {
    private TestAnswerStatusService testAnswerStatusService;
    @Autowired
    TestAnswerStatusController(TestAnswerStatusService testAnswerStatusService) {
        this.testAnswerStatusService = testAnswerStatusService;
    }

    @PostMapping("save")
    @ResponseStatus(HttpStatus.CREATED)
    public void save(@RequestBody List<TestAnswerStatus> testAnswerStatusList) {
        this.testAnswerStatusService.save(testAnswerStatusList);
    }
}
