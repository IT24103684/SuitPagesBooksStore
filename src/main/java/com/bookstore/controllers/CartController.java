package com.bookstore.controllers;

import com.bookstore.dtos.CartDTO;
import com.bookstore.services.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/carts")
public class CartController {

    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getCartByUserId(@PathVariable String userId) {
        try {
            CartDTO cart = cartService.getCartByUserId(userId);
            return ResponseEntity.ok(cart);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/{userId}/items")
    public ResponseEntity<?> addItemToCart(
            @PathVariable String userId,
            @RequestBody Map<String, Object> request) {
        try {
            String bookId = (String) request.get("bookId");
            Integer quantity = (Integer) request.get("quantity");

            if (bookId == null || quantity == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "BookId and quantity are required"));
            }

            CartDTO cart = cartService.addItemToCart(userId, bookId, quantity);
            return ResponseEntity.ok(cart);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/{userId}/items/{bookId}")
    public ResponseEntity<?> removeItemFromCart(
            @PathVariable String userId,
            @PathVariable String bookId) {
        try {
            CartDTO cart = cartService.removeItemFromCart(userId, bookId);
            return ResponseEntity.ok(cart);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/{userId}")
    public ResponseEntity<Void> clearCart(@PathVariable String userId) {
        cartService.clearCart(userId);
        return ResponseEntity.noContent().build();
    }
}