package com.hepan.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hepan.api.entity.Test;
import com.hepan.api.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.SortDefault;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("test")
public class TestController {
    private TestService testService;
    @Autowired
    TestController(TestService testService) {
        this.testService = testService;
    }

    /**
     * 保存随机测试
     *
     * @param test 随机测试数据
     * @return 随机测试
     */
    @PostMapping("save")
    @JsonView(saveJsonView.class)
    @ResponseStatus(HttpStatus.CREATED)
    public Test save(@RequestBody Test test) {
        return this.testService.save(test);
    }

    @GetMapping("{id}")
    @JsonView(getByIdJsonView.class)
    Test getById(@PathVariable Long id) {
        return this.testService.getById(id);
    }

    @GetMapping("get-list-by-user-id/{id}")
    @JsonView(getListByAdUserIdJsonView.class)
    List<Test> getListByAdUserId(@PathVariable Long id) {
        return this.testService.getListByAdUserId(id);
    }

    private interface saveJsonView extends
            Test.IdJsonView,
            Test.NameJsonView,
            Test.QuestionNumJsonView,
            Test.StartTimeJsonView,
            Test.EndTimeJsonView,
            Test.QuestionsJsonView
    {}

    private interface getByIdJsonView extends saveJsonView
    {}

    private interface getListByAdUserIdJsonView extends
            Test.IdJsonView,
            Test.NameJsonView,
            Test.QuestionNumJsonView,
            Test.StartTimeJsonView,
            Test.EndTimeJsonView
    {}
}
