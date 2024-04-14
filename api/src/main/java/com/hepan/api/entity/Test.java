package com.hepan.api.entity;

import com.fasterxml.jackson.annotation.JsonView;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

// 安卓端随机测试实体
@Entity
public class Test {
    @Id
    @JsonView(IdJsonView.class)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonView(NameJsonView.class)
    private String name;

    @JsonView(QuestionNumJsonView.class)
    private String questionNum;

    @JsonView(StartTimeJsonView.class)
    private String startTime;

    @JsonView(EndTimeJsonView.class)
    private String endTime;

    @ManyToMany()
    @JsonView(QuestionsJsonView.class)
    private List<Question> questions = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQuestionNum() {
        return questionNum;
    }

    public void setQuestionNum(String questionNum) {
        this.questionNum = questionNum;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public interface IdJsonView {}
    public interface NameJsonView {}
    public interface QuestionNumJsonView {}
    public interface StartTimeJsonView {}
    public interface EndTimeJsonView {}
    public interface QuestionsJsonView extends
            Question.IdJsonView,
            Question.StemJsonView,
            Question.OptionsJsonView,
            Question.AnswerJsonView
    {}
}
