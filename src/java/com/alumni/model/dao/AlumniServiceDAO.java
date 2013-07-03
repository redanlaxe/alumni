/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.model.dao;

import com.alumni.mapping.Administrateur;
import com.alumni.mapping.Anneedeformation;
import com.alumni.mapping.Competence;
import com.alumni.mapping.Contact;
import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.Experience;
import com.alumni.mapping.Personne;
import com.alumni.mapping.Salaire;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

/**
 *
 * @author Desvides
 */
public interface AlumniServiceDAO {

    public void addEtudiant(String nom, String prenom, String mail, String mdp, String telephone, String adresse, Date dateNaissance, String photoProfil, String cv, String souhaiteEmploi);

    public void addContactEntreprise(String nom, String prenom, String mail, String mdp, String telephone, String poste, Integer idEntreprise);

    public Integer addEntreprise(String nom, String adresse);

    public Personne searchCompte(String mail);

    public Etudiant searchEtudiantById(String id);

    public Etudiant searchEtudiant(String mail);

    public Contact searchContactEntreprise(String mail);

    public ArrayList<Etudiant> getEtudiants();

    public Long countEtudiants();

    public ArrayList<Etudiant> getEtudiantsAnnuaire(Integer debut);

    public Entreprise getEntreprise(String nom);

    public ArrayList<Entreprise> getEntreprises();

    public ArrayList<Experience> getExperienceEtudiant(Integer idEtudiant);

    public ArrayList<Anneedeformation> getAnneedeFormation(Integer idEtudiant);

    public ArrayList<Salaire> getSalaireExperience(Integer idExperience);

    public ArrayList<Competence> getCompetenceExperience(Integer idExperience);

    public Entreprise getEntrepriseExperience(Integer idEntreprise);

    public ArrayList<Competence> getCompetences();

    public Competence getCompetence(String nom);

    public Map getCountCompetences();

    public Map getCountCompetencesStage();

    public Map getCountCompetencesEmploi();

    public Map getCountTypesContrat();

    public Map getFirstTypeContrats();

    public ArrayList<Double> getSalaires(Boolean embauche);

    public void validerc(Integer identifiant);

    public void invaliderc(Integer identifiant);

    public void validere(Integer identifiant);

    public void invalidere(Integer identifiant);

    public ArrayList<Contact> getContactNonValides();

    public ArrayList<Etudiant> getEtudiantNonValides();

    public ArrayList<Administrateur> getAdministrateur();

    public void addAdministrateur(String nom, String prenom, String mail, String mdp);

    public ArrayList<Entreprise> getEntrepriseContactNV();

    public Long countEtudiantsPrive();

    public ArrayList<Etudiant> getEtudiantAnneePrive(Integer annee);

    public ArrayList<Etudiant> getEtudiantsAnnuairePrive(Integer debut);

    public ArrayList<Etudiant> getEtudiantAnnee(Integer annee);

    public ArrayList<String> getDistinctCompetences();

    public void addExperience(int idEtudiant, int idEntreprise, String typeContrat, Date dateDebut, Date dateFin, String poste);

    public void updateEtudiant(Integer idetudiant, String nom, String prenom, String mail, String mdp, String telephone, String adresse, Date datenaiss, String profil, String cv, String souhait);

    public Map getTypeContrat(Boolean embauche);

    public ArrayList getSalairesAvecEtudiant(Boolean embauche);

    public void addAnneeFormation(Integer anneedeb, Integer anneefin, String ecole, String libelle);

    public void updateEtudiant(Etudiant etudiant);

    public void addSalaire(Integer idExperience, Double valeur, Integer annee);

    public void addCompetence(Integer idExperience, String libelle);

    public Experience searchExperience(Integer idExperience);

    public void deleteExperience(Experience exp);

    public Integer addExperience(Integer idEtudiant, Integer idEntreprise, String typeContrat, Date dateDebut, Date dateFin, String poste);

    public ArrayList<String> getDistinctLibellesFormation();

    public ArrayList<String> getDistinctEcoleFormation();

    public String getLibelleFormation(String nom);

    public String getEcoleFormation (String nom);
    
    public Anneedeformation searchFormation(Integer idFormation);
    
    public void removeAnneeEtudiantFormation(Integer idEtudiant,Integer idFormation);
}
