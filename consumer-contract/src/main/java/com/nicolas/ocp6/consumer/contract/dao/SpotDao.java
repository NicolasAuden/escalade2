package com.nicolas.ocp6.consumer.contract.dao;

import com.nicolas.ocp6.model.bean.Spot;

import java.util.List;


public interface SpotDao {
    List<Spot> findSpotsByLocationId(int location);

    Spot findSpotBySpotId(int spotId);

    Spot insertSpot(Spot spot);

    void updateSpot(Spot spot);

    void deleteSpot(int spotId);

    List<Spot> findSpotsBasedOnGuidebookId(int guidebookId);

}
