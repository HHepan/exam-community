package com.hepan.api.repository;

import com.hepan.api.entity.TestAnswerStatus;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface TestAnswerStatusRepository extends PagingAndSortingRepository<TestAnswerStatus, Long>, CrudRepository<TestAnswerStatus, Long>, JpaSpecificationExecutor<TestAnswerStatus> {
}
