package com.bookstore.dtos;

import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

public class CartDTO {
    private String id;

    @NotBlank(message = "User ID is required")
    private String userId;

    @Valid
    private List<CartItemDTO> items = new ArrayList<>();

    public CartDTO() {
    }

    public CartDTO(String userId) {
        this.userId = userId;
    }

    public CartDTO(String id, String userId, List<CartItemDTO> items) {
        this.id = id;
        this.userId = userId;
        this.items = items;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<CartItemDTO> getItems() {
        return items;
    }

    public void setItems(List<CartItemDTO> items) {
        this.items = items;
    }

    public static class CartItemDTO {
        @NotBlank(message = "Book ID is required")
        private String bookId;

        @NotNull(message = "Quantity is required")
        @Min(value = 1, message = "Quantity must be at least 1")
        private Integer quantity;

        public CartItemDTO() {
        }

        public CartItemDTO(String bookId, Integer quantity) {
            this.bookId = bookId;
            this.quantity = quantity;
        }

        public String getBookId() {
            return bookId;
        }

        public void setBookId(String bookId) {
            this.bookId = bookId;
        }

        public Integer getQuantity() {
            return quantity;
        }

        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }
    }
}