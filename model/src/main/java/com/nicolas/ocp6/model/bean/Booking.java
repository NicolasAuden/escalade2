package com.nicolas.ocp6.model.bean;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

public class Booking implements Comparable<Booking>, Serializable {

    private int id;
    private String bookedBy;
    private LocalDate dateFrom;
    private LocalDate dateUntil;
    private String email;
    private String phone;
    private int memberLibrairyMemberId;
    private int memberLibrairyGuidebookId;

    public Booking(int id, String bookedBy, LocalDate dateFrom, LocalDate dateUntil, String email, String phone,
                   int memberLibrairyMemberId, int memberLibrairyGuidebookId) {
        this.id = id;
        this.bookedBy = bookedBy;
        this.dateFrom = dateFrom;
        this.dateUntil = dateUntil;
        this.email = email;
        this.phone = phone;
        this.memberLibrairyMemberId = memberLibrairyMemberId;
        this.memberLibrairyGuidebookId = memberLibrairyGuidebookId;
    }

    public Booking() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBookedBy() {
        return bookedBy;
    }

    public void setBookedBy(String bookedBy) {
        this.bookedBy = bookedBy;
    }

    public LocalDate getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(LocalDate dateFrom) {
        this.dateFrom = dateFrom;
    }

    public LocalDate getDateUntil() {
        return dateUntil;
    }

    public void setDateUntil(LocalDate dateUntil) {
        this.dateUntil = dateUntil;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getMemberLibrairyMemberId() {
        return memberLibrairyMemberId;
    }

    public void setMemberLibrairyMemberId(int memberLibrairyMemberId) {
        this.memberLibrairyMemberId = memberLibrairyMemberId;
    }

    public int getMemberLibrairyGuidebookId() {
        return memberLibrairyGuidebookId;
    }

    public void setMemberLibrairyGuidebookId(int memberLibrairyGuidebookId) {
        this.memberLibrairyGuidebookId = memberLibrairyGuidebookId;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "id=" + id +
                ", bookedBy='" + bookedBy + '\'' +
                ", dateFrom=" + dateFrom +
                ", dateUntil=" + dateUntil +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", memberLibrairyMemberId=" + memberLibrairyMemberId +
                ", memberLibrairyGuidebookId=" + memberLibrairyGuidebookId +
                '}';
    }

    @Override
    public int compareTo(Booking o) {
        return this.getDateFrom().isAfter(o.getDateFrom())?1:this.getDateFrom().isBefore(o.getDateFrom())?-1:0 ;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Booking booking = (Booking) o;
        return id == booking.id &&
                memberLibrairyMemberId == booking.memberLibrairyMemberId &&
                memberLibrairyGuidebookId == booking.memberLibrairyGuidebookId &&
                Objects.equals(bookedBy, booking.bookedBy) &&
                Objects.equals(dateFrom, booking.dateFrom) &&
                Objects.equals(dateUntil, booking.dateUntil) &&
                Objects.equals(email, booking.email) &&
                Objects.equals(phone, booking.phone);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, bookedBy, dateFrom, dateUntil, email, phone, memberLibrairyMemberId, memberLibrairyGuidebookId);
    }
}
