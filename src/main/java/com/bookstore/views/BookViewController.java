package com.bookstore.views;

import com.bookstore.dtos.BookDTO;
import com.bookstore.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import java.util.List;

@Controller
@RequestMapping("/books")
public class BookViewController {
    @Autowired
    private BookService bookService;


    @GetMapping
    public String adminBooks(Model model){
        List<BookDTO> books=  bookService.getAllBooks();
        model.addAttribute("books", books);
        return "books/list";
    }

    @GetMapping("/create")
    public String createBooks(){

        return "books/create";
    }

    @GetMapping("/edit/{id}")
    public String editBooks(@PathVariable String id,Model model){
        BookDTO book=  bookService.getBookById(id);
        model.addAttribute("book", book);
        return "books/edit";
    }
}
