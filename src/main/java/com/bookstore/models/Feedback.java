package com.bookstore.models;

import java.time.LocalDateTime;

public class Feedback extends BaseEntity {
    private String bookId;
    private String userId;
    private String comment;
    private int stars;
    private LocalDateTime createdAt;

    public Feedback() {
        super();
        this.createdAt = LocalDateTime.now();
    }

    public Feedback(String bookId, String userId, String comment, int stars) {
        super();
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.stars = stars;
        this.createdAt = LocalDateTime.now();
    }

    public Feedback(String id, String bookId, String userId, String comment, int stars, LocalDateTime createdAt) {
        super(id);
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.stars = stars;
        this.createdAt = createdAt;
    }


    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getStars() {
        return stars;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return id + "," + bookId + "," + userId + "," + comment + "," + stars + "," + createdAt;
    }
}