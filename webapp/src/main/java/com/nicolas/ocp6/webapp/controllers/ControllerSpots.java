package com.nicolas.ocp6.webapp.controllers;

import com.nicolas.ocp6.business.ServiceGuidebook;
import com.nicolas.ocp6.business.ServiceLocation;
import com.nicolas.ocp6.business.ServiceSpot;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Location;
import com.nicolas.ocp6.model.bean.Spot;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static java.lang.Integer.parseInt;

@SessionAttributes(value = {"alert", "locationInput", "onlySpotsWithBoltedRoutes", "ratingMin", "ratingMax", "guidebookIdForSpots"})
@Controller
public class ControllerSpots {

    @Autowired
    ServiceLocation serviceLocation;

    @Autowired
    ServiceGuidebook serviceGuidebook;

    @Autowired
    ServiceSpot serviceSpot;

    private static final Logger logger = LogManager.getLogger();



    @RequestMapping(value = "/spots", method = RequestMethod.POST)
    public String saveSpotRequestParams(@RequestParam(value = "locationInput") String locationInput,
                                        @RequestParam(value = "onlySpotsWithBoltedRoutes", required = false)
                                                boolean onlySpotsWithBoltedRoutes,
                                        @RequestParam(value = "ratingMin") String ratingMin,
                                        @RequestParam(value = "ratingMax") String ratingMax,
                                        ModelMap model) {


        model.put("locationInput", locationInput);
        model.put("onlySpotsWithBoltedRoutes", onlySpotsWithBoltedRoutes);
        model.put("ratingMin", ratingMin);
        model.put("ratingMax", ratingMax);

        return "redirect:/escalade/displaySpots";
    }


    @RequestMapping(value = "/displaySpots", method = RequestMethod.GET)
    public String displaySpots(@SessionAttribute(value = "locationInput") String locationInput,
                               @SessionAttribute(value = "onlySpotsWithBoltedRoutes", required = false)
                                       boolean onlySpotsWithBoltedRoutes,
                               @SessionAttribute(value = "ratingMin") String ratingMin,
                               @SessionAttribute(value = "ratingMax") String ratingMax,
                               @RequestParam(value = "idSpotToBeCommented") int idSpotToBeCommented,
                               ModelMap model) {

        logger.info("enter method displaySpots");

        List<Location> resultLocations = serviceLocation.detailledInfoBasedOnLocation(locationInput);
        logger.info("after call method detailledInfoBasedOnLocation");

        resultLocations = serviceLocation.filterLocations(resultLocations, onlySpotsWithBoltedRoutes, parseInt(ratingMin), parseInt(ratingMax));
        logger.info("after call method filterLocations");

        serviceLocation.sortLocations(resultLocations);

        model.put("resultLocations", resultLocations);
        model.put("idSpotToBeCommented", idSpotToBeCommented);
        model.put("locationInput", locationInput);
        model.put("alert", "ok");
        return "spots";
    }



    @RequestMapping(value = "/spotsFromGuidebook", method = RequestMethod.GET)
    public String saveRequestParamSpotForAGuidebook(@RequestParam(value = "guidebookIdForSpots") String guidebookIdForSpots,
                                                    ModelMap model) {

        model.put("guidebookIdForSpots", guidebookIdForSpots);
        return "redirect:/escalade/displaySpotsFromGuidebook";
    }



    @RequestMapping(value = "/displaySpotsFromGuidebook", method = RequestMethod.GET)
    public String displaySpotsFromGuidebook(@SessionAttribute(value = "guidebookIdForSpots") String guidebookIdForSpots,
                                            @RequestParam(value = "idSpotToBeCommented") int idSpotToBeCommented,
                                            ModelMap model) {

        logger.info("enter method displaySpotsBasedOnAGuidebook");

        Guidebook selectedGuidebook = serviceGuidebook.findGuidebookbyId(parseInt(guidebookIdForSpots));
        logger.info("after call method findGuidebookbyId");

        List<Spot> spotsForGuidebooks = serviceSpot.findSpotsBasedOnGuidebookId(Integer.parseInt(guidebookIdForSpots));
        logger.info("after call method findSpotsBasedOnGuidebookId");

        selectedGuidebook.setSpots(spotsForGuidebooks);

        serviceSpot.sortSpots(spotsForGuidebooks);


        model.put("selectedGuidebook", selectedGuidebook);
        model.put("idSpotToBeCommented", idSpotToBeCommented);

        return "spotsFromGuidebook";
    }



    @ModelAttribute(value = "idSpotToBeCommented")
    public int getIdSpotToBeCommented() {
        return 0;
    }


}







