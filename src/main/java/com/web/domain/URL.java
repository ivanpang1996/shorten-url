package com.web.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * @author Ivanpang
 */
@Entity
public class URL {
    @Id
    public String suffix;

    @Column(nullable = false)
    public String longUrl;
}
