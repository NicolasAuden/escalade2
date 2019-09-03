package com.nicolas.ocp6.webapp.controllers;

import com.nicolas.ocp6.business.ServiceSpot;
import com.nicolas.ocp6.business.ServiceSpotComment;
import com.nicolas.ocp6.model.bean.Member;
import com.nicolas.ocp6.model.bean.Spot;
import com.nicolas.ocp6.model.bean.SpotComment;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;


@Controller
@SessionAttributes(value = {"user", "selectedSpot"})

public class ControllerAddComment {

    @Autowired
    ServiceSpotComment serviceSpotComment;
    @Autowired
    ServiceSpot serviceSpot;

    private static final Logger logger = LogManager.getLogger();

    /**
     * Controller pour premier com qui vérifie si l'utilisateur est loggué ou non
     * Si oui ->  ControllerSpots
     * Si non ->  Login page
     */
    @RequestMapping(value = "/toNewComment", method = RequestMethod.GET)
    public String displayFormNewComment1(@RequestParam(value = "idSpotToBeCommented") int idSpotToBeCommented,
                                         ModelMap model) {

        // Situation 1: a user has made a spot-search, and is willing to comment one of the displayed spot
        Spot selectedSpot = serviceSpot.findSpotBasedOnId(idSpotToBeCommented);
        model.put("selectedSpot", selectedSpot);
        model.put("idSpotToBeCommented", idSpotToBeCommented);

        if (!model.containsAttribute("user")) {
            model.put("jspAfterLogin", "redirect:/escalade/displaySpots?idSpotToBeCommented=" + idSpotToBeCommented);
            model.put("message", "onlyMembers");
            return ("login");
        } else {

            return ("redirect:/escalade/displaySpots");
        }

    }


    /**
     * Controller pour premier com concernant un spot qui vérifie si l'utilisateur est loggué ou non
     * Si oui ->  ControllerSpots
     * Si non ->  Login page
     */
    @RequestMapping(value = "/toNewCommentForSpotFromGuidebook", method = RequestMethod.GET)
    public String displayFormNewComment2(@RequestParam(value = "idSpotToBeCommented") int idSpotToBeCommented,
                                         ModelMap model) {

        // Situation 2: a user has made a guidebook-search, then has displayed the spots matching to a guidebook, and from there
        // is willing to comment one of the displayed spot

        Spot selectedSpot = serviceSpot.findSpotBasedOnId(idSpotToBeCommented);
        model.put("selectedSpot", selectedSpot);
        model.put("idSpotToBeCommented", idSpotToBeCommented);

        if (!model.containsAttribute("user")) {
            model.put("jspAfterLogin", "redirect:/escalade/displaySpotsFromGuidebook?idSpotToBeCommented=" + idSpotToBeCommented);
            model.put("message", "onlyMembers");
            return ("login");
        } else {

            return ("redirect:/escalade/displaySpotsFromGuidebook");
        }
    }


    /**
     * Controller qui ajoute un com sur un spot dans la bdd et redirige l'utilisateur sur la liste des spots avec le nouveau com
     */
    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String addComment(@RequestParam(value = "comment") String comment,
                             @ModelAttribute(value = "redirect") String redirect,
                             @SessionAttribute(value = "user") Member user,
                             @SessionAttribute(value = "selectedSpot") Spot spotToBeCommented,
                             ModelMap model) {

        SpotComment newCommentWithoutKey = new SpotComment();
        newCommentWithoutKey.setComment(comment);
        newCommentWithoutKey.setMember(user);
        newCommentWithoutKey.setSpot(spotToBeCommented);
        serviceSpotComment.insertSpotComment(newCommentWithoutKey);

        model.put("selectedSpot", spotToBeCommented);
        logger.info(model);

        if (redirect.equals("displaySpotsFomGuidebook")) {
            return "redirect:/escalade/displaySpotsFromGuidebook?idSpotToBeCommented=0";

        } else {
            return "redirect:/escalade/displaySpots?idSpotToBeCommented=0";
        }
    }

}
