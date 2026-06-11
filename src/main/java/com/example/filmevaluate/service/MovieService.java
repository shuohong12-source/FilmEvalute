package com.example.filmevaluate.service;

import com.example.filmevaluate.entity.Comment;
import com.example.filmevaluate.entity.Movie;
import com.example.filmevaluate.entity.Rating;

import java.util.List;

public interface MovieService {
    List<Movie> findAll(String keyword);

    List<Movie> findAllForAdmin(String keyword);

    Movie findById(Long id);

    void saveMovie(Movie movie);

    void updateMovie(Movie movie);

    void deleteMovie(Long id);

    Double getAverageScore(Long movieId);

    Rating getUserRating(Long movieId, Long userId);

    void rateMovie(Long movieId, Long userId, Integer score);

    void addComment(Long movieId, Long userId, String content);

    List<Comment> getComments(Long movieId);
}
