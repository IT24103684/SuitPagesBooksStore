package com.bookstore.views;

import com.bookstore.dtos.CartDTO;
import com.bookstore.services.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/carts")
public class CartViewController {
    @Autowired
    private CartService cartService;

    @GetMapping("/{userId}")
    public String viewCart(@PathVariable String userId, Model model) {
        CartDTO cart = cartService.getCartByUserId(userId);
        model.addAttribute("cart", cart);
        return "carts/view";
    }

    @GetMapping("/checkout/{userId}")
    public String checkout(@PathVariable String userId, Model model) {
        CartDTO cart = cartService.getCartByUserId(userId);
        model.addAttribute("cart", cart);
        return "carts/checkout";
    }
}