package com.bookstore.views;

import com.bookstore.dtos.OrderDTO;
import com.bookstore.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderViewController {
    @Autowired
    private OrderService orderService;

    @GetMapping
    public String adminOrders(Model model){
        List<OrderDTO> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "orders/list";
    }

    @GetMapping("/create")
    public String createOrders(){
        return "orders/create";
    }

    @GetMapping("/edit/{id}")
    public String editOrders(@PathVariable String id, Model model){
        OrderDTO order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        return "orders/edit";
    }

    @GetMapping("/view/{id}")
    public String viewOrder(@PathVariable String id, Model model){
        OrderDTO order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        return "orders/view";
    }
}
