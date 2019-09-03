package com.nicolas.ocp6.consumer.impl.jdbc;

import com.nicolas.ocp6.consumer.contract.dao.MemberLibrairyDao;
import com.nicolas.ocp6.model.bean.Booking;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Member;
import com.nicolas.ocp6.model.bean.MemberLibrairy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

@Component
public class MemberLibrairyDaoImpl extends AbstractDaoImpl implements MemberLibrairyDao {

    @Autowired
    GuidebookDaoImpl guidebookDao;
    @Autowired
    MemberDaoImpl memberDao;


    @Override
    public List<MemberLibrairy> findMemberLibrairyByGuidebookId(int guidebookId) {

        class MemberLibrairyMapper implements RowMapper<MemberLibrairy> {
            @Override
            public MemberLibrairy mapRow(ResultSet rs, int rowNum) throws SQLException {
                MemberLibrairy privateGuidebook = new MemberLibrairy();
                int guidebookId = Integer.parseInt(rs.getString("guidebook_id"));
                int memberId = Integer.parseInt(rs.getString("member_id"));
                int id = Integer.parseInt(rs.getString("id"));
                privateGuidebook.setGuidebook(guidebookDao.findGuidebookById(guidebookId));
                privateGuidebook.setMember(memberDao.findMemberById(memberId));
                privateGuidebook.setId(id);
                return privateGuidebook;
            }
        }

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "select * from member_librairy where member_librairy.guidebook_id = ?";
        List<MemberLibrairy> memberLibrairies = jdbcTemplate.query
                (sqlRequest, new Object[]{guidebookId}, new MemberLibrairyMapper());

        for (Iterator<MemberLibrairy> i = memberLibrairies.iterator(); i.hasNext(); ) {
            MemberLibrairy privateGuidebook = i.next();

            // + Add bookings to privateGuidebook (peut etre factorisé)
            List<Booking> bookings;
            String sqlRequest2 = "select * from booking where member_librairy_id = ?";
            bookings = jdbcTemplate.query(sqlRequest2, new Object[]{privateGuidebook.getId()},
                    new BeanPropertyRowMapper<>(Booking.class));

            privateGuidebook.setBookings(bookings);
        }
        return memberLibrairies;
    }

    @Override
    public MemberLibrairy insertGuidebook(Guidebook selectedGuidebook, Member user) {

        MemberLibrairy ml = new MemberLibrairy();
        ml.setGuidebook(selectedGuidebook);
        ml.setMember(user);

        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into member_librairy(member_id, guidebook_id) values (:member_id, :guidebook_id)";

        SqlParameterSource sqlParameterSource = new MapSqlParameterSource();
        ((MapSqlParameterSource) sqlParameterSource).addValue("member_id", user.getId());
        ((MapSqlParameterSource) sqlParameterSource).addValue("guidebook_id", selectedGuidebook.getId());

        jdbcTemplate.update(sqlQuery, sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        ml.setId(id);


        return ml;
    }

    @Override
    public void removeGuidebook(Guidebook selectedGuidebook, Member user) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from member_librairy where guidebook_id = ? and member_id = ?";
        jdbcTemplate.update(sqlRequest, selectedGuidebook.getId(), user.getId());
    }


    @Override
    public MemberLibrairy findMemberLibrairy(Guidebook selectedGuidebook, Member user) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        MemberLibrairy privateGuidebook;
        String sqlRequest = "select * from member_librairy where guidebook_id = ? and member_id = ?";
        privateGuidebook = jdbcTemplate.queryForObject(sqlRequest, new Object[]{selectedGuidebook.getId(), user.getId()},
                new BeanPropertyRowMapper<>(MemberLibrairy.class));

        // + Add bookings to privateGuidebook
        List<Booking> bookings;
        String sqlRequest2 = "select * from booking where member_librairy_id = ?";
        bookings = jdbcTemplate.query(sqlRequest2, new Object[]{privateGuidebook.getId()},
                new BeanPropertyRowMapper<>(Booking.class));

        privateGuidebook.setBookings(bookings);
        privateGuidebook.setMember(user);
        privateGuidebook.setGuidebook(selectedGuidebook);

        return privateGuidebook;
    }

    @Override
    public Booking insertBooking(MemberLibrairy privateGuidebook, Booking booking) {

        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into booking(booked_by, date_from, date_until, email, phone, member_librairy_id) " +
                "values (:booked_by, :date_from, :date_until, :email, :phone, :member_librairy_id)";

        MapSqlParameterSource sqlParameterSource = new MapSqlParameterSource();
        sqlParameterSource.addValue("booked_by", booking.getBookedBy());
        sqlParameterSource.addValue("date_from", booking.getDateFrom());
        sqlParameterSource.addValue("date_until", booking.getDateUntil());
        sqlParameterSource.addValue("email", booking.getEmail());
        sqlParameterSource.addValue("phone", booking.getPhone());
        sqlParameterSource.addValue("member_librairy_id", privateGuidebook.getId());

        jdbcTemplate.update(sqlQuery, sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        booking.setId(id);

        return booking;
    }

    @Override
    public void removeBooking(int bookingId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from booking where id = ?";
        jdbcTemplate.update(sqlRequest, bookingId);

    }

    @Override
    public void updateBooking(Booking b) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        String SQL = "update booking set booked_by=?, date_from=?, date_until=?, email=?, phone=? where id=?";
        jdbcTemplate.update(SQL, b.getBookedBy(), b.getDateFrom(), b.getDateUntil(), b.getEmail(),
                b.getPhone(), b.getId());
    }


    @Override
    public Booking findBookingById(int bookingId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        String sqlRequest = "select * from booking where id = ?";
        return jdbcTemplate.queryForObject(sqlRequest, new Object[]{bookingId}, new BeanPropertyRowMapper<>(Booking.class));
    }


}
