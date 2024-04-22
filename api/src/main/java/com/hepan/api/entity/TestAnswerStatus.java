package com.hepan.api.entity;

import com.fasterxml.jackson.annotation.JsonView;
import jakarta.persistence.*;

@Entity
public class TestAnswerStatus {
    @Id
    @JsonView(IdJsonView.class)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonView(AdUserAnswerJsonView.class)
    private String adUserAnswer;

    @JsonView(CorrectAnswerJsonView.class)
    private String correctAnswer;

    @JsonView(AnalysisJsonView.class)
    private String analysis;

    @ManyToOne
    @JsonView(AdUserJsonView.class)
    @JoinColumn(name = "ad_user_id")
    private AdUser adUser;

    @ManyToOne
    @JsonView(TestJsonView.class)
    @JoinColumn(name = "test_id")
    private Test test;

    @ManyToOne
    @JsonView(QuestionJsonView.class)
    @JoinColumn(name = "question_id")
    private Question question;

    public Long getId() { return id; }

    public void setId(Long id) { this.id = id; }

    public String getAdUserAnswer() { return adUserAnswer; }

    public void setAdUserAnswer(String adUserAnswer) { this.adUserAnswer = adUserAnswer; }

    public String getCorrectAnswer() { return correctAnswer; }

    public void setCorrectAnswer(String correctAnswer) { this.correctAnswer = correctAnswer; }

    public String getAnalysis() { return analysis; }

    public void setAnalysis(String analysis) { this.analysis = analysis; }

    public AdUser getAdUser() { return adUser; }

    public void setAdUser(AdUser adUser) { this.adUser = adUser; }

    public Test getTest() { return test; }

    public void setTest(Test test) { this.test = test; }

    public Question getQuestion() { return question; }

    public void setQuestion(Question question) { this.question = question; }

    public interface IdJsonView {}
    public interface AdUserAnswerJsonView {}
    public interface CorrectAnswerJsonView {}
    public interface AnalysisJsonView {}
    public interface AdUserJsonView extends
            AdUser.IdJsonView,
            AdUser.NameJsonView
    {}
    public interface TestJsonView extends
            Test.IdJsonView,
            Test.NameJsonView
    {}
    public interface QuestionJsonView extends
            Question.IdJsonView,
            Question.StemJsonView,
            Question.OptionsJsonView,
            Question.AnswerJsonView
    {}
}
