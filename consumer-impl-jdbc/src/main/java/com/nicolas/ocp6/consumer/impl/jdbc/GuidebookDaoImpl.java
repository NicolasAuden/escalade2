package com.nicolas.ocp6.consumer.impl.jdbc;

import com.nicolas.ocp6.consumer.contract.dao.GuidebookDao;
import com.nicolas.ocp6.consumer.contract.dao.SpotCommentDao;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Member;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.Iterator;
import java.util.List;


@Component
public class GuidebookDaoImpl extends AbstractDaoImpl implements GuidebookDao {

    private static final Logger logger = LogManager.getLogger();

    @Autowired
    MemberLibrairyDaoImpl memberLibrairyDao;

    @Autowired
    RouteDaoImpl routeDao;

    @Autowired
    SpotCommentDao spotCommentDao;

    @Autowired
    SpotDaoImpl spotDao;



    @Override
    public List<Guidebook> findGuidebooksBasedOnSpot(int spotId) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "select * from guidebook where guidebook.id in " +
                "(select guidebook_id from association_spot_guidebook " +
                "where association_spot_guidebook.spot_id = ?)";
        List<Guidebook> resultGuidebooks = jdbcTemplate.query(sqlRequest, new Object[]{spotId}, new BeanPropertyRowMapper<>(Guidebook.class));

        for (Iterator<Guidebook> i = resultGuidebooks.iterator(); i.hasNext(); ) {
            Guidebook guidebook = i.next();
            guidebook.setMemberLibrairies(memberLibrairyDao.findMemberLibrairyByGuidebookId(guidebook.getId()));
        }

        return resultGuidebooks;
    }


    @Override
    public Guidebook findGuidebookById(int guidebookId) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "select * from guidebook where guidebook.id = ?";

        return jdbcTemplate.queryForObject(sqlRequest, new Object[]{guidebookId}, new BeanPropertyRowMapper<>(Guidebook.class));
    }


    @Override
    public List<Guidebook> getGuidebooksForLoan(Member member) {


        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "select * from guidebook where guidebook.id in " +
                "(select guidebook_id from member_librairy " +
                "where member_id = ?)";

        return jdbcTemplate.query(sqlRequest, new Object[]{member.getId()},
                new BeanPropertyRowMapper<>(Guidebook.class));
    }


    @Override
    public Guidebook findGuidebookByIsbn(String isbn) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        try {

            String mySqlRequest = "select id from guidebook where isbn13 = ?";
            Guidebook selectedGuidebook = jdbcTemplate.queryForObject(mySqlRequest, new Object[]{isbn}, new BeanPropertyRowMapper<>(Guidebook.class));
            selectedGuidebook = findGuidebookById(selectedGuidebook.getId());
            selectedGuidebook.setSpots(spotDao.findSpotsBasedOnGuidebookId(selectedGuidebook.getId()));
            return selectedGuidebook;

        } catch (EmptyResultDataAccessException e) {
            logger.info("The query has no result.", e);
            return null;
        }
    }


    @Override
    public Guidebook insertGuidebook(Guidebook g) {
        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into guidebook(isbn13, name, year_publication, publisher, language, summary, firstname_author, surname_author)" +
                " values (:isbn13, :name, :year_publication, :publisher, :language, :summary, :firstname_author, :surname_author)";

        MapSqlParameterSource sqlParameterSource = new MapSqlParameterSource();
        sqlParameterSource.addValue("isbn13", g.getIsbn13());
        sqlParameterSource.addValue("name", g.getName());
        sqlParameterSource.addValue("year_publication", g.getYearPublication());
        sqlParameterSource.addValue("publisher", g.getPublisher());
        sqlParameterSource.addValue("language", g.getLanguage());
        sqlParameterSource.addValue("summary", g.getSummary());
        sqlParameterSource.addValue("firstname_author", g.getFirstnameAuthor());
        sqlParameterSource.addValue("surname_author", g.getSurnameAuthor());

        jdbcTemplate.update(sqlQuery, sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        g.setId(id);

        return g;

    }


    @Override
    public void insertRelationGuidebookSpots(List<Integer> listSpotId, Guidebook guidebook) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        String sqlQuery = "insert into association_spot_guidebook(spot_id, guidebook_id) values (?,?)";

        for (Integer i : listSpotId) {
            jdbcTemplate.update(sqlQuery, i, guidebook.getId());
        }

    }

    @Override
    public void updateGuidebook(Guidebook g) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String SQL = "update guidebook set name = ?, year_publication=?, publisher=?, language=?, summary=?," +
                "firstname_author=?, surname_author=? where id = ?";
        jdbcTemplate.update(SQL, g.getName(), g.getYearPublication(), g.getPublisher(), g.getLanguage(), g.getSummary(),
                g.getFirstnameAuthor(), g.getSurnameAuthor(), g.getId());

    }

    @Override
    public void deleteGuidebook(Guidebook g) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from guidebook where id = ?";
        jdbcTemplate.update(sqlRequest, g.getId());
    }


    @Override
    public void deleteRelationGuidebookSpot(int spotId, int guidebookId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from association_spot_guidebook where spot_id = ? and guidebook_id = ? ";
        jdbcTemplate.update(sqlRequest, spotId, guidebookId);

    }

}

