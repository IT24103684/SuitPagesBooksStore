package com.bookstore.models;

import java.io.Serializable;
import java.util.UUID;

public abstract class BaseEntity implements Serializable {
    protected String id;


    protected BaseEntity() {
        this.id = UUID.randomUUID().toString();
    }

    protected BaseEntity(String id) {
        this.id = id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getId() {
        return id;
    }

    public abstract String toString();

}