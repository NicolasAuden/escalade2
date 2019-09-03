package com.nicolas.ocp6.consumer.impl.jdbc;

import com.nicolas.ocp6.consumer.contract.dao.MemberDao;
import com.nicolas.ocp6.model.bean.Member;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;


@Component
public class MemberDaoImpl extends AbstractDaoImpl implements MemberDao {


    @Override
    public List<Member> findAll() {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        return jdbcTemplate.query("select * from member", new BeanPropertyRowMapper<>(Member.class));
    }


    @Override
    public Member findMemberByEmail(String email) {

        try {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
            return jdbcTemplate.queryForObject("select * from member where email ilike '" + email + "'",
                    new BeanPropertyRowMapper<>(Member.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }


    @Override
    public Member insertNewMember(Member m) {
        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into member(first_name, surname, nickname, password, email, phone, date_membership) " +
                "values (:first_name, :surname, :nickname, :password, :email, :phone, :date_membership)";

        MapSqlParameterSource sqlParameterSource = new MapSqlParameterSource();
        sqlParameterSource.addValue("first_name", m.getFirstName());
        sqlParameterSource.addValue("surname", m.getSurname());
        sqlParameterSource.addValue("nickname", m.getNickname());
        sqlParameterSource.addValue("password", m.getPassword());
        sqlParameterSource.addValue("phone", m.getPhone());
        sqlParameterSource.addValue("email", m.getEmail());
        sqlParameterSource.addValue("date_membership", new Date());

        jdbcTemplate.update(sqlQuery, sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        m.setId(id);

        return m;
    }

    @Override
    public Member findMemberbyNickname(String nickname) {
        try {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
            return jdbcTemplate.queryForObject("select * from member where nickname ilike  '" + nickname + "'",
                    new BeanPropertyRowMapper<>(Member.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Member findMemberById(int id) {
        try {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
            return jdbcTemplate.queryForObject("select * from member where id = ?", new Object[]{id},
                    new BeanPropertyRowMapper<>(Member.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public void deleteMemberAccount(int memberId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from member where id = ?";
        jdbcTemplate.update(sqlRequest, memberId);
    }

    @Override
    public int updatePassword(Member member) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String SQL = "update member set password = ? where id = ?";
        return jdbcTemplate.update(SQL, member.getPassword(), member.getId());

    }
}


