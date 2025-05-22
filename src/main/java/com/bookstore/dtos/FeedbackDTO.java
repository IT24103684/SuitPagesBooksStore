package com.bookstore.dtos;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

public class FeedbackDTO {
    private String id;
    
    @NotBlank(message = "Book ID is required")
    private String bookId;
    
    @NotBlank(message = "User ID is required")
    private String userId;
    
    private String comment;
    
    @NotNull(message = "Stars rating is required")
    @Min(value = 1, message = "Stars must be at least 1")
    @Max(value = 5, message = "Stars must be at most 5")
    private Integer stars;
    
    private LocalDateTime createdAt;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String bookId, String userId, String comment, Integer stars) {
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.stars = stars;
        this.createdAt = LocalDateTime.now();
    }

    public FeedbackDTO(String id, String bookId, String userId, String comment, Integer stars, LocalDateTime createdAt) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.stars = stars;
        this.createdAt = createdAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Integer getStars() {
        return stars;
    }

    public void setStars(Integer stars) {
        this.stars = stars;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}