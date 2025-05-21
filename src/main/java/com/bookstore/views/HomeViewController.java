package com.bookstore.views;

import com.bookstore.dtos.BookDTO;
import com.bookstore.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


@Controller
@RequestMapping("/")
public class HomeViewController {

    @Autowired
    private BookService bookService;
    @GetMapping
    public String viewHome(Model model) {
        List<BookDTO> books = bookService.getAllBooks();
        model.addAttribute("books",books);
        return "index";
    }

    @GetMapping("/admin")
    public String viewAdminHome() {
        return "admin/dashboard";
    }

    @GetMapping("/login")
    public String viewLogin() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String viewRegister() {
        return "auth/register";
    }

    @GetMapping("/profile")
    public String viewProfile() {
        return "auth/profile";
    }

    @GetMapping("/checkout")
    public String viewCheckout() {
        return "orders/create";
    }

    @GetMapping("/my-orders")
    public String viewMyOrders() {
        return "orders/my_orders";
    }

    @GetMapping("/admin-login")
    public String viewAdminLogin() {
        return "admin/login";
    }


}
