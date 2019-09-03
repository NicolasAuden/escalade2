package com.nicolas.ocp6.model.bean;

import java.io.Serializable;
import java.util.Objects;
import java.time.LocalDate;

public class SpotComment implements Comparable<SpotComment>, Serializable {

    private int id;
    private String comment;
    private LocalDate date;

    private Spot spot;
    private Member member;

    public SpotComment(int id, int memberId, String comment, LocalDate date, Spot spot, Member member) {
        this.id = id;
        this.comment = comment;
        this.date = date;
        this.spot = spot;
        this.member = member;
    }

    public SpotComment() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Spot getSpot() {
        return spot;
    }

    public void setSpot(Spot spot) {
        this.spot = spot;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    @Override
    public String toString() {
        return "SpotComment{" +
                "id=" + id +
                ", comment='" + comment + '\'' +
                ", date=" + date +
                ", spot=" + spot +
                ", member=" + member +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SpotComment that = (SpotComment) o;
        return id == that.id &&
                Objects.equals(comment, that.comment) &&
                Objects.equals(date, that.date) &&
                Objects.equals(spot, that.spot) &&
                Objects.equals(member, that.member);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, comment, date, spot, member);
    }

    @Override
    public int compareTo(SpotComment o) {
        return this.getDate().isAfter(o.getDate()) ? -1 : this.getDate().isBefore(o.getDate()) ? 1 : 0;
    }
}
