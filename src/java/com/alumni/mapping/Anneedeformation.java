package com.alumni.mapping;



/**
 * Anneedeformation generated by hbm2java
 */
public class Anneedeformation  implements java.io.Serializable {


     private int idformation;
     private int anneeuniversitairedebut;
     private int anneeuniversitairefin;
     private String ecole;
     private String libelle;

    public Anneedeformation() {
    }

    public Anneedeformation(int idformation, int anneeuniversitairedebut, int anneeuniversitairefin, String ecole, String libelle) {
       this.idformation = idformation;
       this.anneeuniversitairedebut = anneeuniversitairedebut;
       this.anneeuniversitairefin = anneeuniversitairefin;
       this.ecole = ecole;
       this.libelle = libelle;
    }
   
    public int getIdformation() {
        return this.idformation;
    }
    
    public void setIdformation(int idformation) {
        this.idformation = idformation;
    }
    public int getAnneeuniversitairedebut() {
        return this.anneeuniversitairedebut;
    }
    
    public void setAnneeuniversitairedebut(int anneeuniversitairedebut) {
        this.anneeuniversitairedebut = anneeuniversitairedebut;
    }
    public int getAnneeuniversitairefin() {
        return this.anneeuniversitairefin;
    }
    
    public void setAnneeuniversitairefin(int anneeuniversitairefin) {
        this.anneeuniversitairefin = anneeuniversitairefin;
    }
    public String getEcole() {
        return this.ecole;
    }
    
    public void setEcole(String ecole) {
        this.ecole = ecole;
    }
    public String getLibelle() {
        return this.libelle;
    }
    
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }




}


