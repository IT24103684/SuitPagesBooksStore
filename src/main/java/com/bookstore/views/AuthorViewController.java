package com.bookstore.views;

import com.bookstore.dtos.AuthorDTO;
import com.bookstore.services.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/authors")
public class AuthorViewController {
    @Autowired
    private AuthorService authorService;

    @GetMapping
    public String adminAuthors(Model model){
        List<AuthorDTO> authors = authorService.getAllAuthors();
        model.addAttribute("authors", authors);
        return "authors/list";
    }

    @GetMapping("/create")
    public String createAuthors(){
        return "authors/create";
    }

    @GetMapping("/edit/{id}")
    public String editAuthors(@PathVariable String id, Model model){
        AuthorDTO author = authorService.getAuthorById(id);
        model.addAttribute("author", author);
        return "authors/edit";
    }
}
