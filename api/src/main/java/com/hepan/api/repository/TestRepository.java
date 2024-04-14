package com.hepan.api.repository;

import com.hepan.api.entity.Test;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface TestRepository extends PagingAndSortingRepository<Test, Long>, CrudRepository<Test, Long>, JpaSpecificationExecutor<Test> {
}
