package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.MemberLibrairyDao;
import com.nicolas.ocp6.model.bean.Booking;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Member;
import com.nicolas.ocp6.model.bean.MemberLibrairy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

@Component
public class ServiceMemberLibrairy {

    @Autowired
    MemberLibrairyDao memberLibrairy;

    @Transactional
    public MemberLibrairy insertGuidebook(Guidebook selectedGuidebook, Member user) {
        return memberLibrairy.insertGuidebook(selectedGuidebook, user);
    }

    @Transactional
    public void removeGuidebook(Guidebook selectedGuidebook, Member user) {
        memberLibrairy.removeGuidebook(selectedGuidebook, user);
    }


    public boolean isAlredayListed(Guidebook selectedGuidebook, List<Guidebook> listGuidebook) {

        // Transform a list of Guidebook objects into a list of Guidebook ID:
        List<Integer> listIdGuidebooks = new ArrayList<>();
        for (Iterator<Guidebook> i = listGuidebook.iterator(); i.hasNext(); ) {
            Guidebook guidebook = i.next();
            listIdGuidebooks.add(guidebook.getId());
        }

        return listIdGuidebooks.contains(selectedGuidebook.getId());
    }


    public MemberLibrairy getMemberLibrairyItem(Guidebook selectedGuidebook, Member user) {
        return memberLibrairy.findMemberLibrairy(selectedGuidebook, user);
    }

    @Transactional
    public Booking insertBooking(MemberLibrairy privateGuidebook, Booking booking) {
        return memberLibrairy.insertBooking(privateGuidebook, booking);
    }

    @Transactional
    public void removeBooking(int bookingId) {
        memberLibrairy.removeBooking(bookingId);
    }

    @Transactional
    public void updateBooking(Booking booking) {
        memberLibrairy.updateBooking(booking);
    }


    public Booking findBookingById(int bookingId) {
        return memberLibrairy.findBookingById(bookingId);
    }



    public boolean periodBookingRequestAvailable(MemberLibrairy privateGuidebook, LocalDate bookingRequestFrom, LocalDate bookingRequestUntil) {
        List<Booking> bookings = privateGuidebook.getBookings();
        for (Iterator<Booking> i = bookings.iterator(); i.hasNext(); ) {
            Booking booking = i.next();
            if (bookingRequestFrom.isAfter(booking.getDateUntil()) || bookingRequestUntil.isBefore(booking.getDateFrom())) {
                continue;
            } else {
                return false;
            }
        }
        return true;
    }

    public boolean periodBookingUpdateAvailable(MemberLibrairy privateGuidebook, Booking selectedBooking, LocalDate newDateFrom, LocalDate newDateUntil) {
        List<Booking> actualBookings = privateGuidebook.getBookings();
        actualBookings.remove(selectedBooking);

        if (periodBookingRequestAvailable(privateGuidebook, newDateFrom, newDateUntil)) {
            actualBookings.add(selectedBooking);
            return true;
        } else {
            actualBookings.add(selectedBooking);
            return false;
        }
    }



    public List<MemberLibrairy> findAvailablePrivateGuidebooks(Guidebook selectedGuidebook, LocalDate date_from, LocalDate date_until) {
        List<MemberLibrairy> listPrivateGuidebooks = memberLibrairy.findMemberLibrairyByGuidebookId(selectedGuidebook.getId());

        for (Iterator<MemberLibrairy> i = listPrivateGuidebooks.iterator(); i.hasNext(); ) {
            MemberLibrairy privateGuidebook = i.next();
            if (!periodBookingRequestAvailable(privateGuidebook, date_from, date_until)) {
                i.remove();
            }
        }
        return listPrivateGuidebooks;
    }


    public List<Booking> sortBooking(List<Booking> bookings) {
        if (bookings != null) {
            Collections.sort(bookings);
        }
        return bookings;
    }


}
