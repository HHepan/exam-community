package com.hepan.api.entity;

import com.fasterxml.jackson.annotation.JsonView;
import jakarta.persistence.*;

@Entity
public class BlogPost {
    @Id
    @JsonView(IdJsonView.class)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonView(PostTimeJsonView.class)
    private String postTime;

    @JsonView(ContentJsonView.class)
    private String content;

    @JsonView(LikesJsonView.class)
    private Long likes;

    @JsonView(CommentsJsonView.class)
    private Long comments;

    @ManyToOne
    @JsonView(AdUserJsonView.class)
    @JoinColumn(name = "ad_user_id")
    private AdUser adUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getLikes() {
        return likes;
    }

    public void setLikes(Long likes) {
        this.likes = likes;
    }

    public Long getComments() {
        return comments;
    }

    public void setComments(Long comments) {
        this.comments = comments;
    }

    public String getPostTime() {
        return postTime;
    }

    public void setPostTime(String postTime) {
        this.postTime = postTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public AdUser getAdUser() {
        return adUser;
    }

    public void setAdUser(AdUser adUser) {
        this.adUser = adUser;
    }

    public interface IdJsonView {}
    public interface PostTimeJsonView {}
    public interface ContentJsonView {}
    public interface LikesJsonView {}
    public interface CommentsJsonView {}
    public interface AdUserJsonView extends
            AdUser.IdJsonView,
            AdUser.NameJsonView
    {}
}
