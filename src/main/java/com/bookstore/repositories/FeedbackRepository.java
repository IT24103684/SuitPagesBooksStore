package com.bookstore.repositories;

import com.bookstore.models.Feedback;
import com.bookstore.utils.FileUtil;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class FeedbackRepository {
    private static final String FEEDBACKS_FILE = "feedbacks.txt";
    private List<Feedback> feedbacks;

    public FeedbackRepository() {
        loadFeedbacks();
    }

    private void loadFeedbacks() {
        feedbacks = FileUtil.loadFromFile(FEEDBACKS_FILE, line -> {
            String[] parts = line.split(",");
            if (parts.length >= 6) {
                return new Feedback(
                        parts[0],
                        parts[1],
                        parts[2],
                        parts[3],
                        Integer.parseInt(parts[4]),
                        LocalDateTime.parse(parts[5])
                );
            }
            return null;
        });
    }

    private void saveFeedbacks() {
        FileUtil.saveToFile(feedbacks, FEEDBACKS_FILE);
    }

    public List<Feedback> findAll() {
        return new ArrayList<>(feedbacks);
    }

    public Optional<Feedback> findById(String id) {
        return feedbacks.stream()
                .filter(feedback -> feedback.getId().equals(id))
                .findFirst();
    }

    public List<Feedback> findByBookId(String bookId) {
        return feedbacks.stream()
                .filter(feedback -> feedback.getBookId().equals(bookId))
                .collect(Collectors.toList());
    }

    public List<Feedback> findByUserId(String userId) {
        return feedbacks.stream()
                .filter(feedback -> feedback.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    public Feedback save(Feedback feedback) {
        Optional<Feedback> existingFeedback = findById(feedback.getId());

        if (existingFeedback.isPresent()) {
            feedbacks.remove(existingFeedback.get());
        }

        feedbacks.add(feedback);
        saveFeedbacks();

        return feedback;
    }

    public boolean deleteById(String id) {
        Optional<Feedback> feedbackToDelete = findById(id);

        if (feedbackToDelete.isPresent()) {
            feedbacks.remove(feedbackToDelete.get());
            saveFeedbacks();
            return true;
        }

        return false;
    }

    public boolean existsByUserIdAndBookId(String userId, String bookId) {
        return feedbacks.stream()
                .anyMatch(feedback ->
                        feedback.getUserId().equals(userId) &&
                                feedback.getBookId().equals(bookId));
    }

    public double getAverageRatingForBook(String bookId) {
        List<Feedback> bookFeedbacks = findByBookId(bookId);

        if (bookFeedbacks.isEmpty()) {
            return 0.0;
        }

        double sum = bookFeedbacks.stream()
                .mapToInt(Feedback::getStars)
                .sum();

        return sum / bookFeedbacks.size();
    }
}