package com.example.filmevaluate.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.filmevaluate.entity.Rating;
import org.apache.ibatis.annotations.Select;

public interface RatingMapper extends BaseMapper<Rating> {
    @Select("select coalesce(round(avg(score), 1), 0) from ratings where movie_id = #{movieId}")
    Double selectAverageScore(Long movieId);
}
