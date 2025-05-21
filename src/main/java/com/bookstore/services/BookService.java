package com.bookstore.services;

import com.bookstore.dtos.BookDTO;
import com.bookstore.models.Book;
import com.bookstore.repositories.AuthorRepository;
import com.bookstore.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final AuthorRepository authorRepository;

    @Autowired
    public BookService(BookRepository bookRepository, AuthorRepository authorRepository) {
        this.bookRepository = bookRepository;
        this.authorRepository = authorRepository;
    }

    public List<BookDTO> getAllBooks() {
        return bookRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public BookDTO getBookById(String id) {
        Optional<Book> book = bookRepository.findById(id);
        return book.map(this::convertToDTO).orElse(null);
    }

    public List<BookDTO> getBooksByCategory(String category) {
        return bookRepository.findByCategory(category).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public List<BookDTO> getBooksByAuthorId(String authorId) {
        return bookRepository.findByAuthorId(authorId).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public List<BookDTO> getBooksSortedByPrice() {
        return bookRepository.findAllSortedByPrice().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public BookDTO createBook(BookDTO bookDTO) {

        if (bookRepository.existsByIsbn(bookDTO.getIsbn())) {
            throw new IllegalArgumentException("ISBN already exists");
        }

        if (!authorRepository.findById(bookDTO.getAuthorId()).isPresent()) {
            throw new IllegalArgumentException("Author not found");
        }

        Book book = convertToEntity(bookDTO);
        Book savedBook = bookRepository.save(book);
        return convertToDTO(savedBook);
    }

    public BookDTO updateBook(String id, BookDTO bookDTO) {
        Optional<Book> existingBook = bookRepository.findById(id);

        if (existingBook.isPresent()) {

            if (!existingBook.get().getIsbn().equals(bookDTO.getIsbn()) &&
                    bookRepository.existsByIsbn(bookDTO.getIsbn())) {
                throw new IllegalArgumentException("ISBN already exists");
            }

            if (!authorRepository.findById(bookDTO.getAuthorId()).isPresent()) {
                throw new IllegalArgumentException("Author not found");
            }

            Book book = convertToEntity(bookDTO);
            book.setId(id);
            Book updatedBook = bookRepository.save(book);
            return convertToDTO(updatedBook);
        }

        return null;
    }

    public boolean deleteBook(String id) {
        return bookRepository.deleteById(id);
    }

    public void updateStock(String id, int quantity) {
        if (quantity > 0) {
            bookRepository.increaseStock(id, quantity);
        } else if (quantity < 0) {
            bookRepository.decreaseStock(id, Math.abs(quantity));
        }
    }

    private BookDTO convertToDTO(Book book) {
        return new BookDTO(
                book.getId(),
                book.getName(),
                book.getIsbn(),
                book.getImageUrl(),
                book.getCategory(),
                book.getPrice(),
                book.getInStock(),
                book.getAuthorId()
        );
    }

    private Book convertToEntity(BookDTO bookDTO) {
        if (bookDTO.getId() != null) {
            return new Book(
                    bookDTO.getId(),
                    bookDTO.getName(),
                    bookDTO.getIsbn(),
                    bookDTO.getImageUrl(),
                    bookDTO.getCategory(),
                    bookDTO.getPrice(),
                    bookDTO.getInStock(),
                    bookDTO.getAuthorId()
            );
        } else {
            return new Book(
                    bookDTO.getName(),
                    bookDTO.getIsbn(),
                    bookDTO.getImageUrl(),
                    bookDTO.getCategory(),
                    bookDTO.getPrice(),
                    bookDTO.getInStock(),
                    bookDTO.getAuthorId()
            );
        }
    }
}
