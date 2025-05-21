package com.bookstore.services;

import com.bookstore.dtos.AuthorDTO;
import com.bookstore.models.Author;
import com.bookstore.repositories.AuthorRepository;
import com.bookstore.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AuthorService {

    private final AuthorRepository authorRepository;
    private final BookRepository bookRepository;

    @Autowired
    public AuthorService(AuthorRepository authorRepository, BookRepository bookRepository) {
        this.authorRepository = authorRepository;
        this.bookRepository = bookRepository;
    }

    public List<AuthorDTO> getAllAuthors() {
        return authorRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public AuthorDTO getAuthorById(String id) {
        Optional<Author> author = authorRepository.findById(id);
        return author.map(this::convertToDTO).orElse(null);
    }

    public AuthorDTO createAuthor(AuthorDTO authorDTO) {
        Author author = convertToEntity(authorDTO);
        Author savedAuthor = authorRepository.save(author);
        return convertToDTO(savedAuthor);
    }

    public AuthorDTO updateAuthor(String id, AuthorDTO authorDTO) {
        Optional<Author> existingAuthor = authorRepository.findById(id);

        if (existingAuthor.isPresent()) {
            Author author = convertToEntity(authorDTO);
            author.setId(id);
            Author updatedAuthor = authorRepository.save(author);
            return convertToDTO(updatedAuthor);
        }

        return null;
    }

    public boolean deleteAuthor(String id) {
        if (!bookRepository.findByAuthorId(id).isEmpty()) {
            throw new IllegalArgumentException("Cannot delete author with associated books");
        }

        return authorRepository.deleteById(id);
    }

    private AuthorDTO convertToDTO(Author author) {
        return new AuthorDTO(
                author.getId(),
                author.getName(),
                author.getGender(),
                author.getImageUrl(),
                author.getAge()
        );
    }

    private Author convertToEntity(AuthorDTO authorDTO) {
        if (authorDTO.getId() != null) {
            return new Author(
                    authorDTO.getId(),
                    authorDTO.getName(),
                    authorDTO.getGender(),
                    authorDTO.getImageUrl(),
                    authorDTO.getAge()
            );
        } else {
            return new Author(
                    authorDTO.getName(),
                    authorDTO.getGender(),
                    authorDTO.getImageUrl(),
                    authorDTO.getAge()
            );
        }
    }
}
