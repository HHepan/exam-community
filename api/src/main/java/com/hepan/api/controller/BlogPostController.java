package com.hepan.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hepan.api.entity.BlogPost;
import com.hepan.api.entity.Test;
import com.hepan.api.service.BlogPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("blog-post")
public class BlogPostController {
    private BlogPostService blogPostService;
    @Autowired
    BlogPostController(BlogPostService blogPostService) {
        this.blogPostService = blogPostService;
    }

    @GetMapping("getAll")
    @JsonView(getAll.class)
    Iterable<BlogPost> getAll() {
        return this.blogPostService.getAll();
    }

    @PostMapping("save")
    void save(@RequestBody BlogPost blogPost) {
        this.blogPostService.save(blogPost);
    }
    private interface getAll extends
            BlogPost.IdJsonView,
            BlogPost.PostTimeJsonView,
            BlogPost.ContentJsonView,
            BlogPost.AdUserJsonView,
            BlogPost.LikesJsonView,
            BlogPost.CommentsJsonView
    {}

}
