package com.example.filmevaluate.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.filmevaluate.entity.Comment;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CommentMapper extends BaseMapper<Comment> {
    @Select("""
            select c.*, u.nickname
            from comments c
            left join users u on c.user_id = u.id
            where c.movie_id = #{movieId}
            order by c.created_at desc
            """)
    List<Comment> selectByMovieId(Long movieId);
}
