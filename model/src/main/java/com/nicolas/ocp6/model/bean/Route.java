package com.nicolas.ocp6.model.bean;

import java.io.Serializable;
import java.util.Objects;

public class Route implements Comparable<Route>, Serializable {

    private int id;
    private String name;
    private byte nbPitch;
    private byte indexPitch;
    private String rating;
    private int nbAnchor;

    private Spot spot;


    public Route(int id, String name, byte nbPitch, byte indexPitch, String rating, Spot spot, int nbAnchor) {
        this.id = id;
        this.name = name;
        this.nbPitch = nbPitch;
        this.indexPitch = indexPitch;
        this.rating = rating;
        this.spot = spot;
        this.nbAnchor = nbAnchor;
    }

    public Route() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte getNbPitch() {
        return nbPitch;
    }

    public void setNbPitch(byte nbPitch) {
        this.nbPitch = nbPitch;
    }

    public byte getIndexPitch() {
        return indexPitch;
    }

    public void setIndexPitch(byte indexPitch) {
        this.indexPitch = indexPitch;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public Spot getSpot() {
        return spot;
    }

    public void setSpot(Spot spot) {
        this.spot = spot;
    }

    public int getNbAnchor() {
        return nbAnchor;
    }

    public void setNbAnchor(int nbAnchor) {
        this.nbAnchor = nbAnchor;
    }

    @Override
    public String toString() {
        return "Route{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", nbPitch=" + nbPitch +
                ", indexPitch=" + indexPitch +
                ", rating='" + rating + '\'' +
                ", spot=" + spot +
                ", nbAnchor=" + nbAnchor +
                '}';
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Route route = (Route) o;
        return id == route.id &&
                nbPitch == route.nbPitch &&
                indexPitch == route.indexPitch &&
                nbAnchor == route.nbAnchor &&
                Objects.equals(name, route.name) &&
                Objects.equals(rating, route.rating) &&
                Objects.equals(spot, route.spot);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, nbPitch, indexPitch, rating, spot, nbAnchor);
    }

    @Override
    public int compareTo(Route o) {
        int comp = this.getName().compareTo(o.getName());
        return comp > 0 ? 1 : comp < 0 ? -1 : 0;
    }
}
