package com.bookstore.controllers;

import com.bookstore.dtos.FeedbackDTO;
import com.bookstore.services.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/feedbacks")
public class FeedbackController {
    
    private final FeedbackService feedbackService;
    
    @Autowired
    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }
    
    @GetMapping
    public ResponseEntity<List<FeedbackDTO>> getAllFeedbacks() {
        List<FeedbackDTO> feedbacks = feedbackService.getAllFeedbacks();
        return ResponseEntity.ok(feedbacks);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<FeedbackDTO> getFeedbackById(@PathVariable String id) {
        FeedbackDTO feedback = feedbackService.getFeedbackById(id);
        return feedback != null ? ResponseEntity.ok(feedback) : ResponseEntity.notFound().build();
    }
    
    @GetMapping("/book/{bookId}")
    public ResponseEntity<List<FeedbackDTO>> getFeedbacksByBookId(@PathVariable String bookId) {
        List<FeedbackDTO> feedbacks = feedbackService.getFeedbacksByBookId(bookId);
        return ResponseEntity.ok(feedbacks);
    }
    
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<FeedbackDTO>> getFeedbacksByUserId(@PathVariable String userId) {
        List<FeedbackDTO> feedbacks = feedbackService.getFeedbacksByUserId(userId);
        return ResponseEntity.ok(feedbacks);
    }
    
    @GetMapping("/book/{bookId}/average-rating")
    public ResponseEntity<Map<String, Double>> getAverageRatingForBook(@PathVariable String bookId) {
        double averageRating = feedbackService.getAverageRatingForBook(bookId);
        return ResponseEntity.ok(Map.of("averageRating", averageRating));
    }
    
    @PostMapping
    public ResponseEntity<?> createFeedback(@Valid @RequestBody FeedbackDTO feedbackDTO) {
        try {
            FeedbackDTO createdFeedback = feedbackService.createFeedback(feedbackDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdFeedback);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<?> updateFeedback(@PathVariable String id, @Valid @RequestBody FeedbackDTO feedbackDTO) {
        try {
            FeedbackDTO updatedFeedback = feedbackService.updateFeedback(id, feedbackDTO);
            return updatedFeedback != null ? ResponseEntity.ok(updatedFeedback) : ResponseEntity.notFound().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFeedback(@PathVariable String id) {
        boolean deleted = feedbackService.deleteFeedback(id);
        return deleted ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }
}