package com.nicolas.ocp6.consumer.impl.jdbc;

import com.nicolas.ocp6.consumer.contract.dao.RouteDao;
import com.nicolas.ocp6.model.bean.Route;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public class RouteDaoImpl extends AbstractDaoImpl implements RouteDao {



    @Override
    public List<Route> findRoutesBasedOnSpot(int spotId) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        String mySqlRequest =   "select * from route where route.spot_id = ?";

        return jdbcTemplate.query (mySqlRequest, new Object[]{spotId}, new BeanPropertyRowMapper<> (Route.class));
    }


    @Override
    public Route insertRoute(Route r) {

        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into route(name, nb_pitch, index_pitch, rating, nb_anchor, spot_id) " +
                "values (:name, :nb_pitch, :index_pitch, :rating, :nb_anchor, :spot_id)";

        MapSqlParameterSource sqlParameterSource = new MapSqlParameterSource();
        sqlParameterSource.addValue("name", r.getName());
        sqlParameterSource.addValue("nb_pitch", r.getNbPitch());
        sqlParameterSource.addValue("index_pitch", r.getIndexPitch());
        sqlParameterSource.addValue("rating", r.getRating());
        sqlParameterSource.addValue("nb_anchor", r.getNbAnchor());
        sqlParameterSource.addValue("spot_id", r.getSpot().getId());

        jdbcTemplate.update(sqlQuery,sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        r.setId(id);

        return r;
    }


    @Override
    public void updateRoute(Route route) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String SQL = "update route set name =?, nb_pitch =?, index_pitch=?, rating=?, nb_anchor=? where id = ?";
        jdbcTemplate.update(SQL, route.getName(), route.getNbPitch(), route.getIndexPitch(), route.getRating(),
                route.getNbAnchor(), route.getId());
    }

    @Override
    public void deleteRoute(int routeId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from route where id = ?";
        jdbcTemplate.update(sqlRequest, routeId);
    }
}
