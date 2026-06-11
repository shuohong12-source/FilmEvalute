package com.example.filmevaluate.controller;

import com.example.filmevaluate.entity.User;
import com.example.filmevaluate.service.MovieService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MovieController {
    private final MovieService movieService;

    public MovieController(MovieService movieService) {
        this.movieService = movieService;
    }

    @GetMapping("/movies")
    public String list(@RequestParam(required = false) String keyword, Model model) {
        model.addAttribute("movies", movieService.findAll(keyword));
        model.addAttribute("keyword", keyword);
        return "movies";
    }

    @GetMapping("/movies/{id}")
    public String detail(@PathVariable Long id, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        Double averageScore = movieService.getAverageScore(id);
        model.addAttribute("movie", movieService.findById(id));
        model.addAttribute("averageScore", averageScore);
        model.addAttribute("scorePercent", averageScore * 10);
        model.addAttribute("comments", movieService.getComments(id));
        model.addAttribute("userRating", loginUser == null ? null : movieService.getUserRating(id, loginUser.getId()));
        return "movie-detail";
    }

    @PostMapping("/movies/{id}/ratings")
    public String rate(@PathVariable Long id,
                       @RequestParam Integer score,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        User loginUser = (User) session.getAttribute("loginUser");
        try {
            movieService.rateMovie(id, loginUser.getId(), score);
            redirectAttributes.addFlashAttribute("message", "评分成功");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/movies/" + id;
    }

    @PostMapping("/movies/{id}/comments")
    public String comment(@PathVariable Long id,
                          @RequestParam String content,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        User loginUser = (User) session.getAttribute("loginUser");
        try {
            movieService.addComment(id, loginUser.getId(), content);
            redirectAttributes.addFlashAttribute("message", "评论成功");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/movies/" + id;
    }
}
