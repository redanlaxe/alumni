package com.alumni.mapping;


/**
 * Contact generated by hbm2java
 */
public class Contact extends Personne implements java.io.Serializable {

    private int idcontact;
    private String nom;
    private String prenom;
    private String mail;
    private String mdp;
    private String telephone;
    private String poste;
    private int identreprise;
    private String validation;

    public Contact() {
        super();
    }

    public Contact(int idcontact, String nom, String prenom, String mail, String mdp, int identreprise) {
        super(nom, prenom, mail, mdp);
        this.idcontact = idcontact;
        this.identreprise = identreprise;
    }

    public Contact(int idcontact, String nom, String prenom, String mail, String mdp, String telephone, String poste, int identreprise, String validation) {
        super(nom, prenom, mail, mdp);
        this.idcontact = idcontact;
        this.telephone = telephone;
        this.poste = poste;
        this.identreprise = identreprise;
        this.validation = validation;
    }

    public int getIdcontact() {
        return this.idcontact;
    }

    public void setIdcontact(int idcontact) {
        this.idcontact = idcontact;
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

    public String getTelephone() {
        return this.telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getPoste() {
        return this.poste;
    }

    public void setPoste(String poste) {
        this.poste = poste;
    }

    public int getIdentreprise() {
        return this.identreprise;
    }

    public void setIdentreprise(int identreprise) {
        this.identreprise = identreprise;
    }

    public String getValidation() {
        return this.validation;
    }

    public void setValidation(String validation) {
        this.validation = validation;
    }
}
