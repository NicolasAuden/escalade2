package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.GuidebookDao;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;


@Component
public class ServiceGuidebook {

    @Autowired
    GuidebookDao guidebookDao;


    public List<Guidebook> filterGuidebooksByLoanAvailable(List<Guidebook> guidebooks, boolean loanRequired) {

        if (loanRequired) {
            for (Iterator<Guidebook> i = guidebooks.iterator(); i.hasNext(); ) {
                Guidebook guidebook = i.next();
                if (guidebook.getMemberLibrairies().isEmpty()) {
                    i.remove();
                }
            }
        }
        return guidebooks;
    }


    public Guidebook findGuidebookbyId(int guidebookId) {
        return guidebookDao.findGuidebookById(guidebookId);
    }


    public List<Guidebook> getGuidebooksForLoan(Member member) {
        return guidebookDao.getGuidebooksForLoan(member);

    }


    public Guidebook findGuidebookbyIsbn(String isbn13) {
        return guidebookDao.findGuidebookByIsbn(isbn13);
    }


    @Transactional
    public void insertRelationGuidebookSpots(List<Integer> listSpotId, Guidebook guidebook) {
        guidebookDao.insertRelationGuidebookSpots(listSpotId, guidebook);
    }


    @Transactional
    public void deleteRelationGuidebookSpot(int spotId, int guidebookId) {
        guidebookDao.deleteRelationGuidebookSpot(spotId, guidebookId);
    }

    @Transactional
    public Guidebook insertGuidebook(Guidebook guidebook) {
        return guidebookDao.insertGuidebook(guidebook);
    }

    @Transactional
    public void updateGuidebook(Guidebook selectedGuidebook) {
        guidebookDao.updateGuidebook(selectedGuidebook);
    }

    @Transactional
    public void deleteGuidebook(Guidebook selectedGuidebook) {
        guidebookDao.deleteGuidebook(selectedGuidebook);
    }


    public List<Guidebook> sortGuidebooks(List<Guidebook> guidebooks) {
        if (guidebooks != null) {
            Collections.sort(guidebooks);
        }
        return guidebooks;
    }
}

