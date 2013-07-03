package com.alumni.mapping;
// Generated 9 avr. 2013 21:29:11 by Hibernate Tools 3.2.1.GA

/**
 * Administrateur generated by hbm2java
 */
public class Administrateur extends Personne implements java.io.Serializable {

    private int idadmin;
    private String nom;
    private String prenom;
    private String mail;
    private String mdp;

    public Administrateur() {
        super();
    }

    public Administrateur(int idadmin, String nom, String prenom, String mail, String mdp) {
        super(nom, prenom, mail, mdp);
        this.idadmin = idadmin;
    }

    public int getIdadmin() {
        return this.idadmin;
    }

    public void setIdadmin(int idadmin) {
        this.idadmin = idadmin;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return this.prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getMail() {
        return this.mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getMdp() {
        return this.mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }
}
