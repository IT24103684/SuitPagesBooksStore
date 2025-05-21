package com.bookstore.repositories;

import com.bookstore.models.Author;
import com.bookstore.utils.FileUtil;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class AuthorRepository {
    private static final String AUTHORS_FILE = "authors.txt";
    private List<Author> authors;

    public AuthorRepository() {
        loadAuthors();
    }

    private void loadAuthors() {
        authors = FileUtil.loadFromFile(AUTHORS_FILE, line -> {
            String[] parts = line.split(",");
            if (parts.length >= 5) {
                return new Author(
                        parts[0],
                        parts[1],
                        parts[2],
                        parts[3],
                        Integer.parseInt(parts[4])
                );
            }
            return null;
        });
    }

    private void saveAuthors() {
        FileUtil.saveToFile(authors, AUTHORS_FILE);
    }

    public List<Author> findAll() {
        return new ArrayList<>(authors);
    }

    public Optional<Author> findById(String id) {
        return authors.stream()
                .filter(author -> author.getId().equals(id))
                .findFirst();
    }

    public Author save(Author author) {
        Optional<Author> existingAuthor = findById(author.getId());

        if (existingAuthor.isPresent()) {
            authors.remove(existingAuthor.get());
        }

        authors.add(author);
        saveAuthors();

        return author;
    }

    public boolean deleteById(String id) {
        Optional<Author> authorToDelete = findById(id);

        if (authorToDelete.isPresent()) {
            authors.remove(authorToDelete.get());
            saveAuthors();
            return true;
        }

        return false;
    }
}
