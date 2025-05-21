package com.bookstore.repositories;

import com.bookstore.models.Cart;
import com.bookstore.utils.FileUtil;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class CartRepository {
    private static final String CARTS_FILE = "carts.txt";
    private List<Cart> carts;

    public CartRepository() {
        loadCarts();
    }

    private void loadCarts() {
        carts = FileUtil.loadFromFile(CARTS_FILE, line -> {
            String[] parts = line.split(",");
            if (parts.length >= 2) {
                Cart cart = new Cart(parts[0], parts[1]); // id, userId

                for (int i = 2; i < parts.length; i++) {
                    String[] itemParts = parts[i].split(":");
                    if (itemParts.length == 2) {
                        String bookId = itemParts[0];
                        int quantity = Integer.parseInt(itemParts[1]);
                        cart.addItem(new Cart.CartItem(bookId, quantity));
                    }
                }

                return cart;
            }
            return null;
        });
    }

    private void saveCarts() {
        FileUtil.saveToFile(carts, CARTS_FILE);
    }

    public List<Cart> findAll() {
        return new ArrayList<>(carts);
    }

    public Optional<Cart> findById(String id) {
        return carts.stream()
                .filter(cart -> cart.getId().equals(id))
                .findFirst();
    }

    public Optional<Cart> findByUserId(String userId) {
        return carts.stream()
                .filter(cart -> cart.getUserId().equals(userId))
                .findFirst();
    }

    public Cart save(Cart cart) {
        Optional<Cart> existingCart = findById(cart.getId());

        if (existingCart.isPresent()) {
            carts.remove(existingCart.get());
        }

        carts.add(cart);
        saveCarts();

        return cart;
    }

    public boolean deleteById(String id) {
        Optional<Cart> cartToDelete = findById(id);

        if (cartToDelete.isPresent()) {
            carts.remove(cartToDelete.get());
            saveCarts();
            return true;
        }

        return false;
    }

    public void clearCart(String userId) {
        Optional<Cart> cartOpt = findByUserId(userId);

        if (cartOpt.isPresent()) {
            Cart cart = cartOpt.get();
            cart.clearCart();
            save(cart);
        }
    }
}