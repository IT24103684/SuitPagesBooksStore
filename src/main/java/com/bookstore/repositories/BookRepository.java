package com.bookstore.repositories;

import com.bookstore.models.Book;
import com.bookstore.utils.LinkedList;
import com.bookstore.utils.QuickSort;
import org.springframework.stereotype.Repository;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class BookRepository {
    private static final String BOOKS_FILE = "data/books.txt";
    private LinkedList<Book> books;

    public BookRepository() {
        loadBooks();
    }

    private void loadBooks() {
        books = new LinkedList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1); // -1 to include empty fields
                if (parts.length >= 8) {
                    try {
                        Book book = new Book(
                                parts[0], // id
                                parts[1], // name
                                parts[2], // isbn
                                parts[3], // imageUrl
                                parts[4], // category
                                Double.parseDouble(parts[5]), // price
                                Integer.parseInt(parts[6]), // inStock
                                parts[7] // authorId
                        );
                        books.add(book); // Directly add to LinkedList
                    } catch (NumberFormatException e) {
                        System.err.println("Skipping invalid line: " + line);
                    }
                } else {
                    System.err.println("Skipping malformed line: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading books file: " + e.getMessage());
        }
    }

    private void saveBooks() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKS_FILE))) {
            for (Book book : books) { // Directly iterate over LinkedList
                writer.write(book.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing to books file: " + e.getMessage());
        }
    }

    public List<Book> findAll() {
        List<Book> bookList = new ArrayList<>();
        for (Book book : books) {
            bookList.add(book);
        }
        return bookList;
    }

    public Optional<Book> findById(String id) {
        for (Book book : books) {
            if (book.getId().equals(id)) {
                return Optional.of(book);
            }
        }
        return Optional.empty();
    }

    public Optional<Book> findByIsbn(String isbn) {
        for (Book book : books) {
            if (book.getIsbn().equals(isbn)) {
                return Optional.of(book);
            }
        }
        return Optional.empty();
    }

    public List<Book> findByCategory(String category) {
        List<Book> result = new ArrayList<>();
        for (Book book : books) {
            if (book.getCategory().equalsIgnoreCase(category)) {
                result.add(book);
            }
        }
        return result;
    }

    public List<Book> findByAuthorId(String authorId) {
        List<Book> result = new ArrayList<>();
        for (Book book : books) {
            if (book.getAuthorId().equals(authorId)) {
                result.add(book);
            }
        }
        return result;
    }

    public Book save(Book book) {
        for (Book existingBook : books) {
            if (existingBook.getId().equals(book.getId())) {
                books.remove(existingBook);
                break;
            }
        }
        books.add(book);
        saveBooks();
        return book;
    }

    public boolean deleteById(String id) {
        for (Book book : books) {
            if (book.getId().equals(id)) {
                books.remove(book);
                saveBooks();
                return true;
            }
        }
        return false;
    }

    public boolean existsByIsbn(String isbn) {
        for (Book book : books) {
            if (book.getIsbn().equals(isbn)) {
                return true;
            }
        }
        return false;
    }

    public List<Book> findAllSortedByPrice() {
        List<Book> bookList = findAll();
        Book[] bookArray = bookList.toArray(new Book[0]);
        QuickSort.sortBooksByPrice(bookArray, 0, bookArray.length - 1);
        List<Book> sortedBooks = new ArrayList<>();
        for (Book book : bookArray) {
            sortedBooks.add(book);
        }
        return sortedBooks;
    }

    public void decreaseStock(String id, int quantity) {
        Optional<Book> optionalBook = findById(id);
        if (optionalBook.isPresent()) {
            Book book = optionalBook.get();
            int newStock = book.getInStock() - quantity;
            if (newStock < 0) {
                throw new IllegalArgumentException("Not enough books in stock");
            }
            book.setInStock(newStock);
            save(book);
        } else {
            throw new IllegalArgumentException("Book not found");
        }
    }

    public void increaseStock(String id, int quantity) {
        Optional<Book> optionalBook = findById(id);
        if (optionalBook.isPresent()) {
            Book book = optionalBook.get();
            book.setInStock(book.getInStock() + quantity);
            save(book);
        } else {
            throw new IllegalArgumentException("Book not found");
        }
    }
}