package com.hepan.api.repository;

import com.hepan.api.entity.AdUser;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface AdUserRepository extends PagingAndSortingRepository<AdUser, Long>, CrudRepository<AdUser, Long>, JpaSpecificationExecutor<AdUser> {
    AdUser findByPhone(String phone);
}
