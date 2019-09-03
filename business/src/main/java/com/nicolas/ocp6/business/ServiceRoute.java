package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.RouteDao;
import com.nicolas.ocp6.model.bean.Route;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;


@Component
public class ServiceRoute {

    @Autowired
    RouteDao routeDao;


    int getRatingAsInt (Route route){
        String fullRating = route.getRating();
        char basicRating = fullRating.charAt(0);
        return java.lang.Character.getNumericValue(basicRating);
    }


    @Transactional
    public Route insertRoute(Route route) {
        return (routeDao.insertRoute(route));
    }

    @Transactional
    public void updateRoute(Route route) {
        routeDao.updateRoute(route);
    }

    @Transactional
    public void deleteRoute(int routeId) {
        routeDao.deleteRoute(routeId);
    }


    public List<Route> sortRoutes(List<Route> routes) {
        if (routes != null) {
            Collections.sort(routes);
        }
        return routes;
    }

}
