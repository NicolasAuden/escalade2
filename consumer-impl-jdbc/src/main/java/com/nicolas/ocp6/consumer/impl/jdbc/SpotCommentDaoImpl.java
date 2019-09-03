package com.nicolas.ocp6.consumer.impl.jdbc;

import com.nicolas.ocp6.consumer.contract.dao.SpotCommentDao;
import com.nicolas.ocp6.model.bean.SpotComment;
import com.nicolas.ocp6.model.bean.Member;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Component
public class SpotCommentDaoImpl extends AbstractDaoImpl implements SpotCommentDao {



    @Override
    public List<SpotComment> findCommentSpotBySpotId(int spotId) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String mySqlRequest = "select * from comment_spot where comment_spot.spot_id = ?";
        List<SpotComment> spotComments = jdbcTemplate.query(mySqlRequest, new Object[]{spotId}, new BeanPropertyRowMapper<>(SpotComment.class));

        for (Iterator<SpotComment> i = spotComments.iterator(); i.hasNext(); ) {
            SpotComment spotComment = i.next();

            mySqlRequest = "select * from member where member.id in (select comment_spot.member_id from comment_spot where comment_spot.id = ?)";
            Member member = jdbcTemplate.queryForObject(mySqlRequest, new Object[]{spotComment.getId()}, new BeanPropertyRowMapper<>(Member.class));

            spotComment.setMember(member);

        }
        return spotComments;
    }


    @Override
    public SpotComment insertSpotComment(SpotComment sc) {
        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into comment_spot(comment, member_id, spot_id, date) values (:comment, :member_id, :spot_id, :date)";

        SqlParameterSource sqlParameterSource= new MapSqlParameterSource();
        ((MapSqlParameterSource) sqlParameterSource).addValue("comment", sc.getComment());
        ((MapSqlParameterSource) sqlParameterSource).addValue("member_id", sc.getMember().getId());
        ((MapSqlParameterSource) sqlParameterSource).addValue("spot_id", sc.getSpot().getId());
        ((MapSqlParameterSource) sqlParameterSource).addValue("date", new Date());


        jdbcTemplate.update(sqlQuery,sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        sc.setId(id);

        return sc;
    }

    @Override
    public void deleteComment(int commentId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from comment_spot where id = ?";
        jdbcTemplate.update(sqlRequest, commentId);
    }


}
