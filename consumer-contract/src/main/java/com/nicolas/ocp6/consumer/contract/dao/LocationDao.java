package com.nicolas.ocp6.consumer.contract.dao;
import com.nicolas.ocp6.model.bean.Location;

import java.util.List;

public interface LocationDao {

    Location findLocationById(int locationInput);

    Location findLocationByNameAndDepartement(String cityName, String departementName);

    List<Location> findLocationsByTableColomn(String locationInput);

    List <String> getLocationProposals(String query);

    List<String> getCityProposalsForUpdateSpots(String query);

    Location insertLocation(Location location);

    Location findLocationBasedOnSpotId(int spotId);

    void deleteLocation(int locationId);




}
