package com.bookstore.views;

import com.bookstore.dtos.AdminDTO;
import com.bookstore.services.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admins")
public class AdminViewController {
    @Autowired
    private AdminService adminService;

    @GetMapping
    public String adminAdmins(Model model){
        List<AdminDTO> admins = adminService.getAllAdmins();
        model.addAttribute("admins", admins);
        return "admin/list";
    }

    @GetMapping("/create")
    public String createAdmins(){
        return "admin/create";
    }

    @GetMapping("/edit/{id}")
    public String editAdmins(@PathVariable String id, Model model){
        AdminDTO admin = adminService.getAdminById(id);
        model.addAttribute("admin", admin);
        return "admin/edit";
    }

    @GetMapping("/feedback")
    public String viewAdminFeedbacks() {
        return "feedbacks/list";
    }

    @GetMapping("/customers")
    public String viewAdminCustomers() {
        return "auth/all";
    }
}