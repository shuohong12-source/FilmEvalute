package com.example.filmevaluate.controller;

import com.example.filmevaluate.entity.Movie;
import com.example.filmevaluate.service.MovieService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/movies")
public class AdminMovieController {
    private final MovieService movieService;

    public AdminMovieController(MovieService movieService) {
        this.movieService = movieService;
    }

    @GetMapping
    public String list(@RequestParam(required = false) String keyword, Model model) {
        model.addAttribute("movies", movieService.findAllForAdmin(keyword));
        model.addAttribute("keyword", keyword);
        return "admin/movies";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("movie", new Movie());
        model.addAttribute("action", "/admin/movies");
        return "admin/movie-form";
    }

    @PostMapping
    public String store(Movie movie, RedirectAttributes redirectAttributes) {
        try {
            movieService.saveMovie(movie);
            redirectAttributes.addFlashAttribute("message", "影片新增成功");
            return "redirect:/admin/movies";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/movies/create";
        }
    }

    @GetMapping("/{id}/edit")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("movie", movieService.findById(id));
        model.addAttribute("action", "/admin/movies/" + id);
        return "admin/movie-form";
    }

    @PostMapping("/{id}")
    public String update(@PathVariable Long id, Movie movie, RedirectAttributes redirectAttributes) {
        try {
            movie.setId(id);
            movieService.updateMovie(movie);
            redirectAttributes.addFlashAttribute("message", "影片修改成功");
            return "redirect:/admin/movies";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/movies/" + id + "/edit";
        }
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        movieService.deleteMovie(id);
        redirectAttributes.addFlashAttribute("message", "影片删除成功");
        return "redirect:/admin/movies";
    }
}
