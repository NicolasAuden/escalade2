package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.LocationDao;
import com.nicolas.ocp6.consumer.contract.dao.SpotDao;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Location;
import com.nicolas.ocp6.model.bean.Spot;
import com.nicolas.ocp6.model.bean.SpotComment;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

@Component
public class ServiceLocation {

    @Autowired
    private LocationDao locationDao;

    @Autowired
    private SpotDao spotDao;

    @Autowired
    private ServiceSpot serviceSpot;

    @Autowired
    private ServiceGuidebook serviceGuidebook;

    @Autowired
    private ServiceSpotComment serviceSpotComment;


    private static final Logger logger = LogManager.getLogger();



    public List<Location> detailledInfoBasedOnLocation(String locationInput) {

        return locationDao.findLocationsByTableColomn(locationInput);
    }



    public List<Location> filterLocations(List<Location> locations, boolean onlyBoltedRoutes, int levelMin, int levelMax) {

        for (Iterator<Location> i = locations.iterator(); i.hasNext(); ) {
            Location location = i.next();
            List<Spot> spots = location.getSpots();
            serviceSpot.filterSpots(spots, onlyBoltedRoutes, levelMin, levelMax);
            if (spots.isEmpty()) {
                i.remove();
            }
        }
        return locations;
    }



    public List<Location> filterLocationsForTopos(List<Location> locations, boolean loanRequired) {
        for (Iterator<Location> i = locations.iterator(); i.hasNext(); ) {
            Location location = i.next();
            List<Spot> spots = location.getSpots();

            for (Iterator<Spot> j = spots.iterator(); j.hasNext(); ) {
                Spot spot = j.next();
                List<Guidebook> guidebooks = spot.getGuidebooks();
                serviceGuidebook.filterGuidebooksByLoanAvailable(guidebooks, loanRequired);
            }
        }
        return locations;
    }


    public List<Guidebook> editGuidebookListWithoutDuplicate(List<Location> locations) {

        List<Guidebook> guidebooksWithoutRepetition = new ArrayList<Guidebook>();

        for (Iterator<Location> k = locations.iterator(); k.hasNext(); ) {
            Location location = k.next();
            List<Spot> spots = location.getSpots();

            for (Iterator<Spot> i = spots.iterator(); i.hasNext(); ) {
                Spot spot = i.next();
                List<Guidebook> listGuidebookToBeAdded = spot.getGuidebooks();

                for (Iterator<Guidebook> j = listGuidebookToBeAdded.iterator(); j.hasNext(); ) {
                    Guidebook guidebook = j.next();

                    if (!guidebooksWithoutRepetition.contains(guidebook)) {
                        guidebooksWithoutRepetition.add(guidebook);
                    }
                }
            }
        }
        return guidebooksWithoutRepetition;
    }


    public List<String> getLocationProposals(String query) {
        return locationDao.getLocationProposals(query);
    }


    public List<String> getCityProposalsForUpdateSpots(String query) {
        return locationDao.getCityProposalsForUpdateSpots(query);
    }


    public Location findLocationByNameAndDepartement(String cityName, String departementName) {
        try {
            return locationDao.findLocationByNameAndDepartement(cityName, departementName);
        } catch (Exception e) {
            logger.info("La recherche ne donne aucun résultat ", e);
            return null;
        }
    }


    @Transactional
    public Spot insertLocationAndItsSpot(Location location, Spot spot) {

        Location newLocationWithKey = locationDao.insertLocation(location);
        spot.setLocation(newLocationWithKey);
        Spot newSpotwithKey = spotDao.insertSpot(spot);
        newSpotwithKey.setLocation(newLocationWithKey);
        return newSpotwithKey;

    }


    public List<Location> removeSpotsAlreadyLinked(List<Location> listLocations, Guidebook selectedGuidebook) {

        // Check if some spots are already stored in the selectedGuidebook
        if (selectedGuidebook.getSpots() == null) {
            return listLocations;
        } else {

            // if, yes get a list of the Ids of the spots already linked to the selectedGuidebook
            List<Integer> spotIdsMatchingWithSelectedGuidebook = new ArrayList<>();
            for (Spot s : selectedGuidebook.getSpots()) {
                spotIdsMatchingWithSelectedGuidebook.add(s.getId());
            }

            // the spot objects matching with these IDs are then removed from the original list of locations
            for (Iterator<Location> i = listLocations.iterator(); i.hasNext(); ) {
                Location location = i.next();
                List<Spot> spots = location.getSpots();

                for (Iterator<Spot> j = spots.iterator(); j.hasNext(); ) {
                    Spot spot = j.next();
                    if ((spotIdsMatchingWithSelectedGuidebook.contains(spot.getId()))) {
                        j.remove();
                    }
                }
            }
            return listLocations;
        }
    }



    public boolean testIfNoSpot(List<Location> listLocations) {

        for (Iterator<Location> i = listLocations.iterator(); i.hasNext(); ) {
            Location location = i.next();
            List<Spot> spots = location.getSpots();
            if (!spots.isEmpty()) {
                return false;
            }
        }
        return true;
    }



    public List<Location> sortLocations(List<Location> locations) {

        if (locations != null) {
            Collections.sort(locations);

            for (Iterator<Location> i = locations.iterator(); i.hasNext(); ) {
                Location location = i.next();
                List<Spot> spots = location.getSpots();

                serviceSpot.sortSpots(spots);

                for (Iterator<Spot> j = spots.iterator(); j.hasNext(); ) {
                    Spot spot = j.next();
                    List<SpotComment> spotComments = spot.getComments();

                    serviceSpotComment.sortSpotComments(spotComments);

                }
            }
        }
        return locations;
    }


}







