package com.example.filmevaluate.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.filmevaluate.entity.Comment;
import com.example.filmevaluate.entity.Movie;
import com.example.filmevaluate.entity.Rating;
import com.example.filmevaluate.mapper.CommentMapper;
import com.example.filmevaluate.mapper.MovieMapper;
import com.example.filmevaluate.mapper.RatingMapper;
import com.example.filmevaluate.service.MovieService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class MovieServiceImpl implements MovieService {
    private final MovieMapper movieMapper;
    private final RatingMapper ratingMapper;
    private final CommentMapper commentMapper;

    public MovieServiceImpl(MovieMapper movieMapper, RatingMapper ratingMapper, CommentMapper commentMapper) {
        this.movieMapper = movieMapper;
        this.ratingMapper = ratingMapper;
        this.commentMapper = commentMapper;
    }

    @Override
    public List<Movie> findAll(String keyword) {
        LambdaQueryWrapper<Movie> query = new LambdaQueryWrapper<Movie>()
                .orderByDesc(Movie::getCreatedAt);
        if (StringUtils.hasText(keyword)) {
            query.like(Movie::getTitle, keyword.trim())
                    .or()
                    .like(Movie::getDirector, keyword.trim())
                    .or()
                    .like(Movie::getGenre, keyword.trim());
        }
        List<Movie> movies = movieMapper.selectList(query);
        for (Movie movie : movies) {
            movie.setAverageScore(getAverageScore(movie.getId()));
        }
        return movies;
    }

    @Override
    public Movie findById(Long id) {
        Movie movie = movieMapper.selectById(id);
        if (movie == null) {
            throw new IllegalArgumentException("影片不存在");
        }
        return movie;
    }

    @Override
    public void saveMovie(Movie movie) {
        validateMovie(movie);
        movie.setCreatedAt(LocalDateTime.now());
        movie.setUpdatedAt(LocalDateTime.now());
        movieMapper.insert(movie);
    }

    @Override
    public void updateMovie(Movie movie) {
        validateMovie(movie);
        movie.setUpdatedAt(LocalDateTime.now());
        movieMapper.updateById(movie);
    }

    @Override
    public void deleteMovie(Long id) {
        movieMapper.deleteById(id);
    }

    @Override
    public Double getAverageScore(Long movieId) {
        return ratingMapper.selectAverageScore(movieId);
    }

    @Override
    public Rating getUserRating(Long movieId, Long userId) {
        if (userId == null) {
            return null;
        }
        return ratingMapper.selectOne(new LambdaQueryWrapper<Rating>()
                .eq(Rating::getMovieId, movieId)
                .eq(Rating::getUserId, userId));
    }

    @Override
    public void rateMovie(Long movieId, Long userId, Integer score) {
        if (score == null || score < 1 || score > 10) {
            throw new IllegalArgumentException("评分必须是 1 到 10 分");
        }
        findById(movieId);
        Rating rating = getUserRating(movieId, userId);
        LocalDateTime now = LocalDateTime.now();
        if (rating == null) {
            rating = new Rating();
            rating.setMovieId(movieId);
            rating.setUserId(userId);
            rating.setScore(score);
            rating.setCreatedAt(now);
            rating.setUpdatedAt(now);
            ratingMapper.insert(rating);
            return;
        }
        rating.setScore(score);
        rating.setUpdatedAt(now);
        ratingMapper.updateById(rating);
    }

    @Override
    public void addComment(Long movieId, Long userId, String content) {
        if (!StringUtils.hasText(content)) {
            throw new IllegalArgumentException("评论内容不能为空");
        }
        findById(movieId);
        Comment comment = new Comment();
        comment.setMovieId(movieId);
        comment.setUserId(userId);
        comment.setContent(content.trim());
        comment.setCreatedAt(LocalDateTime.now());
        commentMapper.insert(comment);
    }

    @Override
    public List<Comment> getComments(Long movieId) {
        return commentMapper.selectByMovieId(movieId);
    }

    private void validateMovie(Movie movie) {
        if (!StringUtils.hasText(movie.getTitle())) {
            throw new IllegalArgumentException("影片名称不能为空");
        }
    }
}
