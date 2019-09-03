package com.nicolas.ocp6.webapp.controllers;

import com.nicolas.ocp6.business.ServiceGuidebook;
import com.nicolas.ocp6.business.ServiceLocation;
import com.nicolas.ocp6.business.ServiceSpot;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Location;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;


@SessionAttributes(value = {"selectedGuidebook", "isbn13", "user", "actualYear"})
@Controller
public class ControllerAddGuidebook {

    private static final Logger logger = LogManager.getLogger();


    @Autowired
    ServiceGuidebook serviceGuidebook;
    @Autowired
    ServiceLocation serviceLocation;
    @Autowired
    ServiceSpot serviceSpot;



    @RequestMapping(value = "/addcontent/guidebook", method = RequestMethod.GET)
    public String goToAddGuidebook(ModelMap model) {

        LocalDate actualDate = LocalDate.now();
        int actualYear = actualDate.getYear();
        model.put("actualYear", actualYear);


        if (model.containsAttribute("user")) {
            return "newGuidebook";

        } else {
            String message = "onlyMembers";
            model.put("message", message);
            model.put("jspAfterLogin", "newGuidebook");
            return "login";
        }
    }



    @RequestMapping(value = "/addcontent/guidebook/isbn")
    public String testIsbn(@RequestParam(value = "isbn13") String isbn13,
                           ModelMap model) {

        Guidebook selectedGuidebook = new Guidebook();

        // If the guidebook whose ISBN has been entered doesn't exist in the DB, it should be referenced first (step2)
        if (serviceGuidebook.findGuidebookbyIsbn(isbn13) == null) {
            selectedGuidebook.setId(-1);
            model.put("step", "step2");
        }
        //Otherwise we can skip directly to the referencing of the matching routes (step3)
        else {
            selectedGuidebook = serviceGuidebook.findGuidebookbyIsbn(isbn13);
            model.put("step", "step3");
        }
        model.put("selectedGuidebook", selectedGuidebook);
        model.put("isbn13", isbn13);

        return "newGuidebook";
    }


    @RequestMapping(value = "/addcontent/guidebook", method = RequestMethod.POST)
    public String saveDetailsGuidebook(@RequestParam(value = "name") String name,
                                       @RequestParam(value = "firstnameAuthor") String firstnameAuthor,
                                       @RequestParam(value = "surnameAuthor") String surnameAuthor,
                                       @RequestParam(value = "yearPublication") short yearPublication,
                                       @RequestParam(value = "publisher") String publisher,
                                       @RequestParam(value = "language") String language,
                                       @RequestParam(value = "summary") String summary,
                                       @SessionAttribute(value = "isbn13") String isbn13,
                                       ModelMap model) {

        Guidebook newGuidebookWithoutKey = new Guidebook();
        newGuidebookWithoutKey.setIsbn13(isbn13);
        newGuidebookWithoutKey.setName(name);
        newGuidebookWithoutKey.setFirstnameAuthor(firstnameAuthor);
        newGuidebookWithoutKey.setSurnameAuthor(surnameAuthor);
        newGuidebookWithoutKey.setPublisher(publisher);
        newGuidebookWithoutKey.setYearPublication(yearPublication);
        newGuidebookWithoutKey.setLanguage(language);
        newGuidebookWithoutKey.setSummary(summary);

        Guidebook newGuidebookWithKey = serviceGuidebook.insertGuidebook(newGuidebookWithoutKey);

        model.put("selectedGuidebook", newGuidebookWithKey);
        model.put("step", "step3");

        return "newGuidebook";
    }


    @RequestMapping(value = "/spotsForGuidebook", method = RequestMethod.GET)
    public String displaySpots(@RequestParam(value = "locationSpotsForGuidebook") String locationSpotsForGuidebook,
                               @ModelAttribute(value = "selectedGuidebook") Guidebook selectedGuidebook,
                               ModelMap model) {
        try {
            List<Location> listMatchingLocations = serviceLocation.detailledInfoBasedOnLocation(locationSpotsForGuidebook);
            listMatchingLocations = serviceLocation.removeSpotsAlreadyLinked(listMatchingLocations, selectedGuidebook);
            boolean noSpot = serviceLocation.testIfNoSpot(listMatchingLocations);

            model.put("listMatchingLocations", listMatchingLocations);

            if (noSpot) {
                model.put("alert", "noSpot");
            } else {
                model.put("alert", "ok");
            }

        } catch (Exception e) {
            logger.info(e);
            model.put("alert", "notFound");
        }
        model.put("step", "step3");
        return "newGuidebook";
    }


    @RequestMapping(value = "/spotsForGuidebook", method = RequestMethod.POST)
    public String addSpotstoGuide(@ModelAttribute(value = "selectedGuidebook") Guidebook selectedGuidebook,
                                  @RequestParam(value = "selectedSpots") List<Integer> listSpotId,
                                  ModelMap model) {

        serviceGuidebook.insertRelationGuidebookSpots(listSpotId, selectedGuidebook);

        selectedGuidebook = serviceGuidebook.findGuidebookbyIsbn(selectedGuidebook.getIsbn13());
        model.put("selectedGuidebook", selectedGuidebook);
        model.put("step", "step3");
        return "newGuidebook";
    }
}
