package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.LocationDao;
import com.nicolas.ocp6.consumer.contract.dao.SpotDao;
import com.nicolas.ocp6.model.bean.Location;
import com.nicolas.ocp6.model.bean.Route;
import com.nicolas.ocp6.model.bean.Spot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;

@Component
public class ServiceSpot {

    @Autowired
    ServiceRoute serviceRoute;

    @Autowired
    SpotDao spotDao;

    @Autowired
    LocationDao locationDao;

    @Autowired
    ServiceSpotComment serviceSpotComment;



    public List<Spot> filterSpots(List<Spot> spots, boolean onlyBoltedRoutes, int levelMin, int levelMax) {

        for (Iterator<Spot> i = spots.iterator(); i.hasNext(); ) {
            Spot spot = i.next();
            List<Route> routes = spot.getRoutes();

            for (Iterator<Route> j = routes.iterator(); j.hasNext(); ) {
                Route route = j.next();

                boolean isBolted = false;
                if (route.getNbAnchor() > 0) {
                    isBolted = true;
                }

                if ((!isBolted && onlyBoltedRoutes) || serviceRoute.getRatingAsInt(route) < levelMin ||
                        serviceRoute.getRatingAsInt(route) > levelMax) {
                    j.remove();
                }
            }
            if (routes.isEmpty()) {
                i.remove();
            }
        }
        return spots;
    }


    public Spot findSpotBasedOnId(int spotId) {
        return spotDao.findSpotBySpotId(spotId);
    }


    @Transactional
    public Spot insertSpot(Spot spot) {
        return spotDao.insertSpot(spot);
    }


    @Transactional
    public void updateSpot(Spot spot) {
        spotDao.updateSpot(spot);
    }



    @Transactional
    public void deleteSpot(int spotId) {

        Location locationWithoutSpot = findSpotBasedOnId(spotId).getLocation();
        Location locationWithSpot = locationDao.findLocationById(locationWithoutSpot.getId());

        if (locationWithSpot.getSpots().size() == 1) {
            locationDao.deleteLocation(locationWithSpot.getId());
        }
        spotDao.deleteSpot(spotId);
    }


    public List<Spot> findSpotsBasedOnGuidebookId(int guidebookId) {
        return spotDao.findSpotsBasedOnGuidebookId(guidebookId);
    }



    public List<Spot> sortSpots(List<Spot> spots) {

        if (spots != null) {
            Collections.sort(spots);

            for (Iterator<Spot> j = spots.iterator(); j.hasNext(); ) {
                Spot spot = j.next();
                serviceSpotComment.sortSpotComments(spot.getComments());
                serviceRoute.sortRoutes(spot.getRoutes());
            }
        }
        return spots;
    }


}