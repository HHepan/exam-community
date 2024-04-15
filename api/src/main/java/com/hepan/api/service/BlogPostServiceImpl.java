package com.hepan.api.service;

import com.hepan.api.entity.BlogPost;
import com.hepan.api.repository.BlogPostRepository;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class BlogPostServiceImpl implements BlogPostService  {
    private BlogPostRepository blogPostRepository;
    BlogPostServiceImpl(BlogPostRepository blogPostRepository) {
        this.blogPostRepository = blogPostRepository;
    }

    @Override
    public Iterable<BlogPost> getAll() {
        return this.blogPostRepository.findAllByOrderByPostTimeDesc();
    }

    @Override
    public void save(BlogPost blogPost) {
        this.blogPostRepository.save(blogPost);
    }
}
