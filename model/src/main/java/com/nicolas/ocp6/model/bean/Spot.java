package com.nicolas.ocp6.model.bean;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

public class Spot implements Comparable<Spot>, Serializable {

    private int id;
    private String nameSpot;
    private String nameArea;
    private String access;
    private Location location;
    private List<Route> routes;
    private List<Guidebook> guidebooks;
    private List<SpotComment> comments;

    public Spot(int id, String nameSpot, String nameArea, String access, Location location, List<Route> routes, List<Guidebook> guidebooks, List<SpotComment> comments) {
        this.id = id;
        this.nameSpot = nameSpot;
        this.nameArea = nameArea;
        this.access = access;
        this.location = location;
        this.routes = routes;
        this.guidebooks = guidebooks;
        this.comments = comments;
    }

    public Spot() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameSpot() {
        return nameSpot;
    }

    public void setNameSpot(String nameSpot) {
        this.nameSpot = nameSpot;
    }

    public String getNameArea() {
        return nameArea;
    }

    public void setNameArea(String nameArea) {
        this.nameArea = nameArea;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public List<Route> getRoutes() {
        return routes;
    }

    public void setRoutes(List<Route> routes) {
        this.routes = routes;
    }

    public List<Guidebook> getGuidebooks() {
        return guidebooks;
    }

    public void setGuidebooks(List<Guidebook> guidebooks) {
        this.guidebooks = guidebooks;
    }

    public List<SpotComment> getComments() {
        return comments;
    }

    public void setComments(List<SpotComment> comments) {
        this.comments = comments;
    }

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    @Override
    public String toString() {
        return "Spot{" +
                "id=" + id +
                ", nameSpot='" + nameSpot + '\'' +
                ", nameArea='" + nameArea + '\'' +
                ", access='" + access + '\'' +
                ", location=" + location +
                ", routes=" + routes +
                ", guidebooks=" + guidebooks +
                ", comments=" + comments +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Spot spot = (Spot) o;
        return id == spot.id &&
                Objects.equals(nameSpot, spot.nameSpot) &&
                Objects.equals(nameArea, spot.nameArea) &&
                Objects.equals(access, spot.access) &&
                Objects.equals(location, spot.location) &&
                Objects.equals(routes, spot.routes) &&
                Objects.equals(guidebooks, spot.guidebooks) &&
                Objects.equals(comments, spot.comments);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nameSpot, nameArea, access, location, routes, guidebooks, comments);
    }

    @Override
    public int compareTo(Spot o) {
        int comp = this.getNameSpot().compareTo(o.getNameSpot());

        if (o.getNameArea() == null) {
            o.setNameArea("");
        }

        if (this.getNameArea() == null) {
            this.setNameArea("");
        }

        int comp2 = this.getNameArea().compareTo(o.getNameArea());
        return comp > 0 ? 1 : comp < 0 ? -1 : comp2 > 0 ? 1 : comp2 < 0 ? -1 : 0;
    }
}
