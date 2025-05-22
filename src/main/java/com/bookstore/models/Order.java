package com.bookstore.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Order extends BaseEntity {
    private String userId;
    private List<OrderItem> items;
    private String address;
    private String status;
    private LocalDateTime orderDate;

    public Order() {
        super();
        this.items = new ArrayList<>();
        this.orderDate = LocalDateTime.now();
    }

    public Order(String userId, String address) {
        super();
        this.userId = userId;
        this.address = address;
        this.status = "PENDING";
        this.items = new ArrayList<>();
        this.orderDate = LocalDateTime.now();
    }

    public Order(String id, String userId, String address, String status, LocalDateTime orderDate) {
        super(id);
        this.userId = userId;
        this.address = address;
        this.status = status;
        this.items = new ArrayList<>();
        this.orderDate = orderDate;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public void addItem(OrderItem item) {
        items.add(item);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append(",").append(userId).append(",").append(address).append(",").append(status).append(",").append(orderDate);

        for (OrderItem item : items) {
            sb.append(",").append(item.getBookId()).append(":").append(item.getQuantity()).append(":").append(item.getPrice());
        }

        return sb.toString();
    }

    public static class OrderItem implements Serializable {
        private String bookId;
        private int quantity;
        private double price;

        public OrderItem() {
        }

        public OrderItem(String bookId, int quantity, double price) {
            this.bookId = bookId;
            this.quantity = quantity;
            this.price = price;
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

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }
    }
}