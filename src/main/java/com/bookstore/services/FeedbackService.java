package com.bookstore.services;

import com.bookstore.dtos.FeedbackDTO;
import com.bookstore.models.Feedback;
import com.bookstore.repositories.BookRepository;
import com.bookstore.repositories.FeedbackRepository;
import com.bookstore.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final UserRepository userRepository;
    private final BookRepository bookRepository;

    @Autowired
    public FeedbackService(FeedbackRepository feedbackRepository, UserRepository userRepository, BookRepository bookRepository) {
        this.feedbackRepository = feedbackRepository;
        this.userRepository = userRepository;
        this.bookRepository = bookRepository;
    }

    public List<FeedbackDTO> getAllFeedbacks() {
        return feedbackRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public FeedbackDTO getFeedbackById(String id) {
        Optional<Feedback> feedback = feedbackRepository.findById(id);
        return feedback.map(this::convertToDTO).orElse(null);
    }

    public List<FeedbackDTO> getFeedbacksByBookId(String bookId) {
        return feedbackRepository.findByBookId(bookId).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTO> getFeedbacksByUserId(String userId) {
        return feedbackRepository.findByUserId(userId).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public FeedbackDTO createFeedback(FeedbackDTO feedbackDTO) {
        // Check if user exists
        if (!userRepository.findById(feedbackDTO.getUserId()).isPresent()) {
            throw new IllegalArgumentException("User not found");
        }

        // Check if book exists
        if (!bookRepository.findById(feedbackDTO.getBookId()).isPresent()) {
            throw new IllegalArgumentException("Book not found");
        }

        // Check if user already gave feedback for this book
        if (feedbackRepository.existsByUserIdAndBookId(feedbackDTO.getUserId(), feedbackDTO.getBookId())) {
            throw new IllegalArgumentException("User already gave feedback for this book");
        }

        Feedback feedback = convertToEntity(feedbackDTO);
        feedback.setCreatedAt(LocalDateTime.now());

        Feedback savedFeedback = feedbackRepository.save(feedback);
        return convertToDTO(savedFeedback);
    }

    public FeedbackDTO updateFeedback(String id, FeedbackDTO feedbackDTO) {
        Optional<Feedback> existingFeedback = feedbackRepository.findById(id);

        if (existingFeedback.isPresent()) {
            // Cannot change book or user
            feedbackDTO.setBookId(existingFeedback.get().getBookId());
            feedbackDTO.setUserId(existingFeedback.get().getUserId());

            Feedback feedback = convertToEntity(feedbackDTO);
            feedback.setId(id);
            feedback.setCreatedAt(existingFeedback.get().getCreatedAt());

            Feedback updatedFeedback = feedbackRepository.save(feedback);
            return convertToDTO(updatedFeedback);
        }

        return null;
    }



    public boolean deleteFeedback(String id) {
        return feedbackRepository.deleteById(id);
    }

    public double getAverageRatingForBook(String bookId) {
        return feedbackRepository.getAverageRatingForBook(bookId);
    }

    private FeedbackDTO convertToDTO(Feedback feedback) {
        return new FeedbackDTO(
                feedback.getId(),
                feedback.getBookId(),
                feedback.getUserId(),
                feedback.getComment(),
                feedback.getStars(),
                feedback.getCreatedAt()
        );
    }

    private Feedback convertToEntity(FeedbackDTO feedbackDTO) {
        if (feedbackDTO.getId() != null) {
            return new Feedback(
                    feedbackDTO.getId(),
                    feedbackDTO.getBookId(),
                    feedbackDTO.getUserId(),
                    feedbackDTO.getComment(),
                    feedbackDTO.getStars(),
                    feedbackDTO.getCreatedAt() != null ? feedbackDTO.getCreatedAt() : LocalDateTime.now()
            );
        } else {
            return new Feedback(
                    feedbackDTO.getBookId(),
                    feedbackDTO.getUserId(),
                    feedbackDTO.getComment(),
                    feedbackDTO.getStars()
            );
        }
    }
}