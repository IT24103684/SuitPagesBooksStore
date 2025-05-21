package com.bookstore.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Cart extends BaseEntity {
    private String userId;
    private List<CartItem> items;

    public Cart() {
        super();
        this.items = new ArrayList<>();
    }

    public Cart(String userId) {
        super();
        this.userId = userId;
        this.items = new ArrayList<>();
    }

    public Cart(String id, String userId) {
        super(id);
        this.userId = userId;
        this.items = new ArrayList<>();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public void addItem(CartItem item) {
        for (CartItem existingItem : items) {
            if (existingItem.getBookId().equals(item.getBookId())) {
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item);
    }

    public void removeItem(String bookId) {
        items.removeIf(item -> item.getBookId().equals(bookId));
    }

    public void clearCart() {
        items.clear();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append(",").append(userId);

        for (CartItem item : items) {
            sb.append(",").append(item.getBookId()).append(":").append(item.getQuantity());
        }

        return sb.toString();
    }

    public static class CartItem implements Serializable {
        private String bookId;
        private int quantity;

        public CartItem() {
        }

        public CartItem(String bookId, int quantity) {
            this.bookId = bookId;
            this.quantity = quantity;
        }

        public String getBookId() {
            return bookId;
        }

        public void setBookId(String bookId) {
            this.bookId = bookId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }
}