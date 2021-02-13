package com.web.repository;

import com.web.domain.URL;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;

/**
 * @author Ivanpang
 */
public interface URLRepository extends JpaRepository<URL, String> {
    @Modifying
    @Transactional
    @Query(nativeQuery = true, value = "insert into test.url (suffix, long_url) values (:suffix, :url)")
    void insert(@Param("suffix") String suffix, @Param("url") String url);
}
