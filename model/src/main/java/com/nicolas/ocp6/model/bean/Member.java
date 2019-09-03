package com.nicolas.ocp6.model.bean;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

public class Member implements Serializable {

    private int id;
    private String firstName;
    private String surname;
    private String nickname;
    private String password;
    private String email;
    private String phone;
    private LocalDate dateMembership;

    public Member() {
    }

    public Member(int id, String firstName, String surname, String nickname, String password, String email, String phone, LocalDate dateMembership) {
        this.id = id;
        this.firstName = firstName;
        this.surname = surname;
        this.nickname = nickname;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.dateMembership = dateMembership;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public LocalDate getDateMembership() {
        return dateMembership;
    }

    public void setDateMembership(LocalDate dateMembership) {
        this.dateMembership = dateMembership;
    }

    @Override
    public String toString() {
        return "Member{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", surname='" + surname + '\'' +
                ", nickname='" + nickname + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", dateMembership=" + dateMembership +
                '}';
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Member member = (Member) o;
        return id == member.id &&
                Objects.equals(firstName, member.firstName) &&
                Objects.equals(surname, member.surname) &&
                Objects.equals(nickname, member.nickname) &&
                Objects.equals(password, member.password) &&
                Objects.equals(email, member.email) &&
                Objects.equals(phone, member.phone) &&
                Objects.equals(dateMembership, member.dateMembership);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, firstName, surname, nickname, password, email, phone, dateMembership);
    }
}
