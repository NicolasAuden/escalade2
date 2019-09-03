package com.nicolas.ocp6.model.bean;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

public class Guidebook implements Comparable<Guidebook>, Serializable {
    private int id;
    private String isbn13;
    private String name;
    private short yearPublication;
    private String publisher;
    private String language;
    private String summary;
    private String firstnameAuthor;
    private String SurnameAuthor;
    private List <MemberLibrairy> memberLibrairies;
    private List <Spot> spots;


    public Guidebook(int id, String isbn13, String name, short yearPublication, String publisher, String language, String summary,
                     String firstnameAuthor, String surnameAuthor,
                     List<MemberLibrairy> memberLibrairies, List<Spot> spots) {
        this.id = id;
        this.isbn13 = isbn13;
        this.name = name;
        this.yearPublication = yearPublication;
        this.publisher = publisher;
        this.language = language;
        this.summary = summary;
        this.firstnameAuthor = firstnameAuthor;
        SurnameAuthor = surnameAuthor;
        this.memberLibrairies = memberLibrairies;
        this.spots = spots;
    }

    public Guidebook() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIsbn13() {
        return isbn13;
    }

    public void setIsbn13(String isbn13) {
        this.isbn13 = isbn13;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public short getYearPublication() {
        return yearPublication;
    }

    public void setYearPublication(short yearPublication) {
        this.yearPublication = yearPublication;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getFirstnameAuthor() {
        return firstnameAuthor;
    }

    public void setFirstnameAuthor(String firstnameAuthor) {
        this.firstnameAuthor = firstnameAuthor;
    }

    public String getSurnameAuthor() {
        return SurnameAuthor;
    }

    public void setSurnameAuthor(String surnameAuthor) {
        SurnameAuthor = surnameAuthor;
    }

    public List<MemberLibrairy> getMemberLibrairies() {
        return memberLibrairies;
    }

    public void setMemberLibrairies(List<MemberLibrairy> memberLibrairies) {
        this.memberLibrairies = memberLibrairies;
    }

    public List<Spot> getSpots() {
        return spots;
    }

    public void setSpots(List<Spot> spots) {
        this.spots = spots;
    }

    @Override
    public String toString() {
        return "Guidebook{" +
                "id=" + id +
                ", isbn13='" + isbn13 + '\'' +
                ", name='" + name + '\'' +
                ", yearPublication=" + yearPublication +
                ", publisher='" + publisher + '\'' +
                ", language='" + language + '\'' +
                ", summary='" + summary + '\'' +
                ", firstnameAuthor='" + firstnameAuthor + '\'' +
                ", SurnameAuthor='" + SurnameAuthor + '\'' +
                ", memberLibrairies=" + memberLibrairies +
                ", spots=" + spots +
                '}';
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Guidebook guidebook = (Guidebook) o;
        return id == guidebook.id &&
                yearPublication == guidebook.yearPublication &&
                Objects.equals(isbn13, guidebook.isbn13) &&
                Objects.equals(name, guidebook.name) &&
                Objects.equals(publisher, guidebook.publisher) &&
                Objects.equals(language, guidebook.language) &&
                Objects.equals(summary, guidebook.summary) &&
                Objects.equals(firstnameAuthor, guidebook.firstnameAuthor) &&
                Objects.equals(SurnameAuthor, guidebook.SurnameAuthor) &&
                Objects.equals(memberLibrairies, guidebook.memberLibrairies) &&
                Objects.equals(spots, guidebook.spots);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, isbn13, name, yearPublication, publisher, language, summary, firstnameAuthor, SurnameAuthor, memberLibrairies, spots);
    }

    @Override
    public int compareTo(Guidebook o) {
        int comp = this.getName().compareTo(o.getName());
        return comp > 0 ? 1 : comp < 0 ? -1 : 0;
    }
}
