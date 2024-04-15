package com.hepan.api.repository;

import com.hepan.api.entity.BlogPost;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface BlogPostRepository extends PagingAndSortingRepository<BlogPost, Long>, CrudRepository<BlogPost, Long>, JpaSpecificationExecutor<BlogPost> {
    Iterable<BlogPost> findAllByOrderByPostTimeDesc();
}
