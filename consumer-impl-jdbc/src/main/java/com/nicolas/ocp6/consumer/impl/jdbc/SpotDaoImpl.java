package com.nicolas.ocp6.consumer.impl.jdbc;

import com.nicolas.ocp6.consumer.contract.dao.SpotDao;
import com.nicolas.ocp6.model.bean.Location;
import com.nicolas.ocp6.model.bean.Spot;
import org.springframework.beans.factory.annotation.Autowired;
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
public class SpotDaoImpl extends AbstractDaoImpl implements SpotDao {


    @Autowired
    RouteDaoImpl routeDao;
    @Autowired
    GuidebookDaoImpl guidebookDao;
    @Autowired
    SpotCommentDaoImpl commentSpotDao;
    @Autowired
    LocationDaoImpl locationDao;



    @Override
    public List<Spot> findSpotsByLocationId(int locationId) {

        List<Spot> myResults;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String mySqlRequest = "select * from spot where spot.location_id = ?";
        myResults = jdbcTemplate.query(mySqlRequest, new Object[]{locationId}, new BeanPropertyRowMapper(Spot.class));

        for (Iterator<Spot> i = myResults.iterator(); i.hasNext(); ) {
            Spot spot = i.next();
            spot.setRoutes(routeDao.findRoutesBasedOnSpot(spot.getId()));
            spot.setGuidebooks(guidebookDao.findGuidebooksBasedOnSpot(spot.getId()));
            spot.setComments(commentSpotDao.findCommentSpotBySpotId(spot.getId()));
        }
        return myResults;
    }


    @Override
    public List<Spot> findSpotsBasedOnGuidebookId(int guidebookId) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "select * from spot where spot.id in " +
                "(select spot_id from association_spot_guidebook " +
                "where association_spot_guidebook.guidebook_id = ?)";

        List<Spot> spots = jdbcTemplate.query(sqlRequest, new Object[]{guidebookId}, new BeanPropertyRowMapper<>(Spot.class));

        //ADD DATA FOR MATCHING LOCATION
        sqlRequest = "select * from location where location.id in " +
                "(select location_id from spot " +
                "where spot.id = ?)";

        for (Iterator<Spot> i = spots.iterator(); i.hasNext(); ) {
            Spot spot = i.next();
            Location location = jdbcTemplate.queryForObject(sqlRequest, new Object[]{spot.getId()},
                    new BeanPropertyRowMapper<>(Location.class));

            spot.setLocation(location);

            spot.setRoutes(routeDao.findRoutesBasedOnSpot(spot.getId()));
            spot.setGuidebooks(guidebookDao.findGuidebooksBasedOnSpot(spot.getId()));
            spot.setComments(commentSpotDao.findCommentSpotBySpotId(spot.getId()));
        }

        return spots;
    }



    @Override
    public Spot findSpotBySpotId(int spotId) {

        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String mySqlRequest = "select * from spot where spot.id = ?";
        Spot selectedSpot = jdbcTemplate.queryForObject(mySqlRequest, new Object[]{spotId}, new BeanPropertyRowMapper<>(Spot.class));

        selectedSpot.setRoutes(routeDao.findRoutesBasedOnSpot(spotId));
        selectedSpot.setGuidebooks(guidebookDao.findGuidebooksBasedOnSpot(spotId));
        selectedSpot.setLocation(locationDao.findLocationBasedOnSpotId(spotId));

        return selectedSpot;
    }


    @Override
    public Spot insertSpot(Spot s) {
        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getDataSource());
        KeyHolder holder = new GeneratedKeyHolder();

        String sqlQuery = "insert into spot(name_spot, name_area, access, location_id) values (:name_spot, :name_area, :access, :location_id)";

        MapSqlParameterSource sqlParameterSource = new MapSqlParameterSource();
        sqlParameterSource.addValue("name_spot", s.getNameSpot());
        sqlParameterSource.addValue("name_area", s.getNameArea());
        sqlParameterSource.addValue("name_area", s.getNameArea());
        sqlParameterSource.addValue("access", s.getAccess());
        sqlParameterSource.addValue("location_id", s.getLocation().getId());

        jdbcTemplate.update(sqlQuery, sqlParameterSource, holder, new String[]{"id"});

        int id = holder.getKey().intValue();
        s.setId(id);

        return s;

    }

    @Override
    public void updateSpot(Spot spot) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String SQL = "update spot set name_spot = ?, name_area = ? , access= ? where id = ?";
        jdbcTemplate.update(SQL, spot.getNameSpot(), spot.getNameArea(), spot.getAccess(), spot.getId());

    }


    @Override
    public void deleteSpot(int spotId) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

        String sqlRequest = "delete from spot where id = ?";
        jdbcTemplate.update(sqlRequest, spotId);
    }
}
