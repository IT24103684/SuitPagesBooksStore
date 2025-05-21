package com.bookstore.services;

import com.bookstore.dtos.OrderDTO;
import com.bookstore.models.Book;
import com.bookstore.models.Cart;
import com.bookstore.models.Order;
import com.bookstore.repositories.BookRepository;
import com.bookstore.repositories.CartRepository;
import com.bookstore.repositories.OrderRepository;
import com.bookstore.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final BookRepository bookRepository;

    @Autowired
    public OrderService(OrderRepository orderRepository, CartRepository cartRepository,
                        UserRepository userRepository, BookRepository bookRepository) {
        this.orderRepository = orderRepository;
        this.cartRepository = cartRepository;
        this.userRepository = userRepository;
        this.bookRepository = bookRepository;
    }

    public List<OrderDTO> getAllOrders() {
        return orderRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public OrderDTO getOrderById(String id) {
        Optional<Order> order = orderRepository.findById(id);
        return order.map(this::convertToDTO).orElse(null);
    }

    public List<OrderDTO> getOrdersByUserId(String userId) {
        return orderRepository.findByUserId(userId).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public OrderDTO createOrder(String userId, String address) {
        // Check if user exists
        if (!userRepository.findById(userId).isPresent()) {
            throw new IllegalArgumentException("User not found");
        }

        // Get cart
        Optional<Cart> cartOpt = cartRepository.findByUserId(userId);

        if (!cartOpt.isPresent() || cartOpt.get().getItems().isEmpty()) {
            throw new IllegalArgumentException("Cart is empty");
        }

        Cart cart = cartOpt.get();

        // Create order
        Order order = new Order(userId, address);

        // Add items to order
        for (Cart.CartItem cartItem : cart.getItems()) {
            Optional<Book> bookOpt = bookRepository.findById(cartItem.getBookId());

            if (!bookOpt.isPresent()) {
                throw new IllegalArgumentException("Book not found: " + cartItem.getBookId());
            }

            Book book = bookOpt.get();

            // Check stock
            if (book.getInStock() < cartItem.getQuantity()) {
                throw new IllegalArgumentException("Not enough books in stock: " + book.getName());
            }

            // Add item to order
            order.addItem(new Order.OrderItem(
                    cartItem.getBookId(),
                    cartItem.getQuantity(),
                    book.getPrice()
            ));

            // Decrease stock
            bookRepository.decreaseStock(book.getId(), cartItem.getQuantity());
        }

        // Save order
        Order savedOrder = orderRepository.save(order);

        // Clear cart
        cartRepository.clearCart(userId);

        return convertToDTO(savedOrder);
    }

    public OrderDTO updateOrderStatus(String id, String status) {
        Optional<Order> orderOpt = orderRepository.findById(id);

        if (!orderOpt.isPresent()) {
            throw new IllegalArgumentException("Order not found");
        }

        Order order = orderOpt.get();
        order.setStatus(status);

        Order updatedOrder = orderRepository.save(order);
        return convertToDTO(updatedOrder);
    }

    public boolean deleteOrder(String id) {
        Optional<Order> orderOpt = orderRepository.findById(id);

        if (!orderOpt.isPresent()) {
            return false;
        }

        Order order = orderOpt.get();

        // If order is not yet delivered, return items to stock
        if (!order.getStatus().equalsIgnoreCase("DELIVERED")) {
            for (Order.OrderItem item : order.getItems()) {
                bookRepository.increaseStock(item.getBookId(), item.getQuantity());
            }
        }

        return orderRepository.deleteById(id);
    }

    public List<OrderDTO> getOrdersByStatus(String status) {
        return orderRepository.findByStatus(status).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    private OrderDTO convertToDTO(Order order) {
        List<OrderDTO.OrderItemDTO> itemDTOs = order.getItems().stream()
                .map(item -> new OrderDTO.OrderItemDTO(item.getBookId(), item.getQuantity(), item.getPrice()))
                .collect(Collectors.toList());

        return new OrderDTO(
                order.getId(),
                order.getUserId(),
                order.getAddress(),
                order.getStatus(),
                order.getOrderDate(),
                itemDTOs
        );
    }
}