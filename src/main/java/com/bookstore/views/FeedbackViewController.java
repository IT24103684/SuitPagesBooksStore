package com.bookstore.views;

import com.bookstore.dtos.FeedbackDTO;
import com.bookstore.services.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/feedback")
public class FeedbackViewController {
    @Autowired
    private FeedbackService feedbackService;

    @GetMapping
    public String adminFeedback(Model model){
        List<FeedbackDTO> feedbacks = feedbackService.getAllFeedbacks();
        model.addAttribute("feedbacks", feedbacks);
        return "feedback/list";
    }

    @GetMapping("/view/{id}")
    public String viewFeedback(@PathVariable String id, Model model){
        FeedbackDTO feedback = feedbackService.getFeedbackById(id);
        model.addAttribute("feedback", feedback);
        return "feedback/view";
    }

    @GetMapping("/respond/{id}")
    public String respondToFeedback(@PathVariable String id, Model model){
        FeedbackDTO feedback = feedbackService.getFeedbackById(id);
        model.addAttribute("feedback", feedback);
        return "feedback/respond";
    }
}
