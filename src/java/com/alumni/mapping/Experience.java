package com.alumni.mapping;
// Generated 9 avr. 2013 21:29:11 by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * Experience generated by hbm2java
 */
public class Experience  implements java.io.Serializable {


     private int idexperience;
     private int identreprise;
     private int idetudiant;
     private String typecontrat;
     private Date debut;
     private Date fin;
     private String intituleposte;

    public Experience() {
    }

	
    public Experience(int idexperience, int identreprise, int idetudiant, String typecontrat, Date debut, String intituleposte) {
        this.idexperience = idexperience;
        this.identreprise = identreprise;
        this.idetudiant = idetudiant;
        this.typecontrat = typecontrat;
        this.debut = debut;
        this.intituleposte = intituleposte;
    }
    public Experience(int idexperience, int identreprise, int idetudiant, String typecontrat, Date debut, Date fin, String intituleposte) {
       this.idexperience = idexperience;
       this.identreprise = identreprise;
       this.idetudiant = idetudiant;
       this.typecontrat = typecontrat;
       this.debut = debut;
       this.fin = fin;
       this.intituleposte = intituleposte;
    }
   
    public int getIdexperience() {
        return this.idexperience;
    }
    
    public void setIdexperience(int idexperience) {
        this.idexperience = idexperience;
    }
    public int getIdentreprise() {
        return this.identreprise;
    }
    
    public void setIdentreprise(int identreprise) {
        this.identreprise = identreprise;
    }
    public int getIdetudiant() {
        return this.idetudiant;
    }
    
    public void setIdetudiant(int idetudiant) {
        this.idetudiant = idetudiant;
    }
    public String getTypecontrat() {
        return this.typecontrat;
    }
    
    public void setTypecontrat(String typecontrat) {
        this.typecontrat = typecontrat;
    }
    public Date getDebut() {
        return this.debut;
    }
    
    public void setDebut(Date debut) {
        this.debut = debut;
    }
    public Date getFin() {
        return this.fin;
    }
    
    public void setFin(Date fin) {
        this.fin = fin;
    }
    public String getIntituleposte() {
        return this.intituleposte;
    }
    
    public void setIntituleposte(String intituleposte) {
        this.intituleposte = intituleposte;
    }




}


