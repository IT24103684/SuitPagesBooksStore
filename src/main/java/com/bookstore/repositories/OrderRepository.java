package com.bookstore.repositories;

import com.bookstore.models.Order;
import com.bookstore.utils.FileUtil;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class OrderRepository {
    private static final String ORDERS_FILE = "orders.txt";
    private List<Order> orders;

    public OrderRepository() {
        loadOrders();
    }

    private void loadOrders() {
        orders = FileUtil.loadFromFile(ORDERS_FILE, line -> {
            String[] parts = line.split(",");
            if (parts.length >= 5) {
                Order order = new Order(
                        parts[0],
                        parts[1],
                        parts[2],
                        parts[3],
                        LocalDateTime.parse(parts[4])
                );

                for (int i = 5; i < parts.length; i++) {
                    String[] itemParts = parts[i].split(":");
                    if (itemParts.length == 3) {
                        String bookId = itemParts[0];
                        int quantity = Integer.parseInt(itemParts[1]);
                        double price = Double.parseDouble(itemParts[2]);
                        order.addItem(new Order.OrderItem(bookId, quantity, price));
                    }
                }

                return order;
            }
            return null;
        });
    }

    private void saveOrders() {
        FileUtil.saveToFile(orders, ORDERS_FILE);
    }

    public List<Order> findAll() {
        return new ArrayList<>(orders);
    }

    public Optional<Order> findById(String id) {
        return orders.stream()
                .filter(order -> order.getId().equals(id))
                .findFirst();
    }

    public List<Order> findByUserId(String userId) {
        return orders.stream()
                .filter(order -> order.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    public Order save(Order order) {
        Optional<Order> existingOrder = findById(order.getId());

        if (existingOrder.isPresent()) {
            orders.remove(existingOrder.get());
        }

        orders.add(order);
        saveOrders();

        return order;
    }

    public boolean deleteById(String id) {
        Optional<Order> orderToDelete = findById(id);

        if (orderToDelete.isPresent()) {
            orders.remove(orderToDelete.get());
            saveOrders();
            return true;
        }

        return false;
    }

    public List<Order> findByStatus(String status) {
        return orders.stream()
                .filter(order -> order.getStatus().equalsIgnoreCase(status))
                .collect(Collectors.toList());
    }
}