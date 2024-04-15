package com.hepan.api.service;

import com.hepan.api.entity.BlogPost;

public interface BlogPostService {
    Iterable<BlogPost> getAll();

    void save(BlogPost blogPost);
}
