package com.nicolas.ocp6.consumer.contract.dao;


import com.nicolas.ocp6.model.bean.Booking;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Member;
import com.nicolas.ocp6.model.bean.MemberLibrairy;

import java.util.List;

public interface MemberLibrairyDao {

    List<MemberLibrairy> findMemberLibrairyByGuidebookId(int GuidebookId);

    MemberLibrairy insertGuidebook(Guidebook selectedGuidebook, Member user);

    void removeGuidebook(Guidebook selectedGuidebook, Member user);

    MemberLibrairy findMemberLibrairy(Guidebook selectedGuidebook, Member user);

    Booking insertBooking(MemberLibrairy privateGuidebook, Booking booking);

    void removeBooking(int bookingId);

    void updateBooking(Booking booking);

    Booking findBookingById(int bookingId);

}
