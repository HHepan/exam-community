package com.hepan.api.entity;

import com.fasterxml.jackson.annotation.JsonView;
import jakarta.persistence.*;

import java.util.List;

// 安卓用户实体
@Entity
public class AdUser {
    @Id
    @JsonView(IdJsonView.class)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonView(NameJsonView.class)
    private String name;

    @JsonView(PhoneJsonView.class)
    private String phone;

    @JsonView(PasswordJsonView.class)
    private String password;

    @JsonView(SexJsonView.class)
    private String sex;

    @JsonView(AgeJsonView.class)
    private String age;

    @JsonView(EmailJsonView.class)
    private String email;

    @OneToMany( mappedBy = "adUser" )
    @JsonView(TestAnswerStatusJsonView.class)
    private List<TestAnswerStatus> testAnswerStatus;

    @OneToMany( mappedBy = "adUser" )
    @JsonView(BlogPostJsonView.class)
    private List<BlogPost> blogPost;

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<TestAnswerStatus> getTestAnswerStatus() {
        return testAnswerStatus;
    }

    public void setTestAnswerStatus(List<TestAnswerStatus> email) {
        this.testAnswerStatus = testAnswerStatus;
    }

    public List<BlogPost> getBlogPost() {
        return blogPost;
    }

    public void setBlogPost(List<BlogPost> blogPost) {
        this.blogPost = blogPost;
    }

    public interface IdJsonView {}
    public interface NameJsonView {}
    public interface PhoneJsonView {}
    public interface PasswordJsonView {}
    public interface SexJsonView {}
    public interface AgeJsonView {}
    public interface EmailJsonView {}
    public interface TestAnswerStatusJsonView {}
    public interface BlogPostJsonView {}
}
