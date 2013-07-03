package com.alumni.model.dao;

import com.alumni.controller.Alumni;
import com.alumni.mapping.Administrateur;
import com.alumni.mapping.Anneedeformation;
import com.alumni.mapping.Competence;
import com.alumni.mapping.Contact;
import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.EtudiantanneeId;
import com.alumni.mapping.Experience;
import com.alumni.mapping.Personne;
import com.alumni.mapping.Salaire;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class AlumniService implements AlumniServiceDAO {

    Transaction transaction;
    Session session;

    public AlumniService() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    @Override
    public void addEtudiant(String nom, String prenom, String mail, String mdp, String telephone, String adresse, Date dateNaissance, String photoProfil, String cv, String souhaiteEmploi) {
        try {
            Etudiant e = new Etudiant();
            e.setNom(nom);
            e.setPrenom(prenom);
            e.setMail(mail);
            e.setMdp(mdp);
            e.setTelephone(telephone);
            e.setAdresse(adresse);
            e.setDatenaissance(dateNaissance);
            e.setPhotoprofil(photoProfil);
            e.setCv(cv);
            e.setSouhaiteemploi(souhaiteEmploi);
            e.setValidation("n");
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void addContactEntreprise(String nom, String prenom, String mail, String mdp, String telephone, String poste, Integer idEntreprise) {
        try {
            Contact c = new Contact();
            c.setNom(nom);
            c.setPrenom(prenom);
            c.setMail(mail);
            c.setMdp(mdp);
            c.setTelephone(telephone);
            c.setPoste(poste);
            c.setIdentreprise(idEntreprise);
            c.setValidation("n");
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(c);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public Integer addEntreprise(String nom, String adresse) {
        try {
            Entreprise e = new Entreprise();
            e.setNomentreprise(nom);
            e.setAdresse(adresse);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(e);
            session.refresh(e);
            session.getTransaction().commit();
            return e.getIdentreprise();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return 0;
    }

    @Override
    public Personne searchCompte(String mail) {
        Personne p = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            // On regarde si le compte existe dans la table des étudiants dans celle des contacts d'entreprise puis dans la liste d'administrateurs
            p = (Etudiant) session.createQuery("FROM Etudiant AS e WHERE e.mail = '" + mail + "'").uniqueResult();
            if (p == null) {
                transaction = session.beginTransaction();
                p = (Contact) session.createQuery("FROM Contact AS c WHERE c.mail = '" + mail + "'").uniqueResult();
                if (p == null) {
                    transaction = session.beginTransaction();
                    p = (Administrateur) session.createQuery("FROM Administrateur AS a WHERE a.mail = '" + mail + "'").uniqueResult();
                }
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return p;
    }

    @Override
    public Etudiant searchEtudiantById(String id) {
        try {
            transaction = session.beginTransaction();
            Etudiant e = (Etudiant) session.createQuery("FROM Etudiant AS e WHERE e.idetudiant = " + Integer.valueOf(id)).uniqueResult();
            return e;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Etudiant searchEtudiant(String mail) {
        try {
            transaction = session.beginTransaction();
            Etudiant e = (Etudiant) session.createQuery("FROM Etudiant AS e WHERE e.mail = '" + mail + "'").uniqueResult();
            return e;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Etudiant> getEtudiants() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            ArrayList<Etudiant> results = new ArrayList();
            transaction = session.beginTransaction();
            results = (ArrayList<Etudiant>) session.createQuery("FROM Etudiant as e WHERE e.validation='y'").list();
            return results;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Long countEtudiants() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Long result = (Long) session.createQuery("select count(*) FROM Etudiant as e WHERE e.validation='y'").uniqueResult();
            return result;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Etudiant> getEtudiantsAnnuaire(Integer debut) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            ArrayList<Etudiant> results = new ArrayList();
            transaction = session.beginTransaction();
            Query q = session.createQuery("FROM Etudiant as e WHERE e.validation='y'");
            q.setFirstResult(debut);
            q.setMaxResults(10);
            results = (ArrayList<Etudiant>) q.list();
            return results;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Contact searchContactEntreprise(String mail) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Contact e = (Contact) session.createQuery("FROM Contact AS e WHERE e.mail = '" + mail + "'").uniqueResult();
            return e;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Experience> getExperienceEtudiant(Integer idEtudiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Experience> listeExp = (ArrayList<Experience>) session.createQuery("FROM Experience AS e WHERE e.idetudiant = " + idEtudiant).list();
            return listeExp;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Salaire> getSalaireExperience(Integer idExperience) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Salaire> listeSal = (ArrayList<Salaire>) session.createQuery("FROM Salaire AS s WHERE s.idexperience = " + idExperience).list();
            return listeSal;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Entreprise getEntreprise(String nom) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Entreprise e = (Entreprise) session.createQuery("FROM Entreprise as e WHERE lower(e.nomentreprise) ='" + nom.toLowerCase() + "'").uniqueResult();
            return e;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Entreprise> getEntreprises() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            return (ArrayList<Entreprise>) session.createQuery("FROM Entreprise as e").list();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Competence> getCompetenceExperience(Integer idExperience) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Competence> listeComp = (ArrayList<Competence>) session.createQuery("FROM Competence AS e WHERE e.idexperience = " + idExperience).list();
            return listeComp;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Competence> getCompetences() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            return (ArrayList<Competence>) session.createQuery("FROM Competence").list();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Entreprise getEntrepriseExperience(Integer idEntreprise) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Entreprise listeEntreprise = (Entreprise) session.createQuery("FROM Entreprise AS E WHERE E.identreprise=" + idEntreprise).uniqueResult();
            return listeEntreprise;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Anneedeformation> getAnneedeFormation(Integer idEtudiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Anneedeformation> listeEntreprise = (ArrayList<Anneedeformation>) session.createQuery("FROM Experience AS EXP, Entreprise AS E WHERE E.IDENTREPRISE=" + idEtudiant + "AND E.IDENTREPRISE=EXP.IDENTREPRISE").list();
            return listeEntreprise;
            /*SELECT E.* 
             FROM Experience AS EXP, Entreprise AS E
             WHERE E.IDENTREPRISE=1
             AND E.IDENTREPRISE=EXP.IDENTREPRISE*/
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Map getCountCompetences() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            List<Object[]> competences = session.createSQLQuery("select libelle, count(libelle) as nb from alumni.competence group by libelle order by nb desc").list();
            HashMap<String, Integer> countCompetences = new HashMap<String, Integer>();
            for (Object[] competence : competences) {
                countCompetences.put((String) competence[0], (Integer) competence[1]);
            }
            return Alumni.sortByValues(countCompetences);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Map getCountCompetencesStage() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            List<Object[]> competences = session.createSQLQuery("select libelle, count(libelle) as nb from alumni.competence c, alumni.experience e where c.IDEXPERIENCE = e.IDEXPERIENCE and e.TYPECONTRAT = 'stage' group by libelle order by nb desc").list();
            HashMap<String, Integer> countCompetences = new HashMap<String, Integer>();
            for (Object[] competence : competences) {
                countCompetences.put((String) competence[0], (Integer) competence[1]);
            }
            return Alumni.sortByValues(countCompetences);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Map getCountCompetencesEmploi() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            List<Object[]> competences = session.createSQLQuery("select libelle, count(libelle) as nb from alumni.competence c, alumni.experience e where c.IDEXPERIENCE = e.IDEXPERIENCE and e.TYPECONTRAT != 'stage' group by libelle order by nb desc").list();
            HashMap<String, Integer> countCompetences = new HashMap<String, Integer>();
            for (Object[] competence : competences) {
                countCompetences.put((String) competence[0], (Integer) competence[1]);
            }
            return Alumni.sortByValues(countCompetences);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Map getCountTypesContrat() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            List<Object[]> contrats = session.createSQLQuery("select typecontrat, count(typecontrat) as nb from alumni.experience group by typecontrat").list();
            HashMap<String, Integer> countContrats = new HashMap<String, Integer>();
            for (Object[] contrat : contrats) {
                countContrats.put((String) contrat[0], (Integer) contrat[1]);
            }
            return countContrats;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Map getFirstTypeContrats() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            List<Object[]> contrats = session.createSQLQuery("select typecontrat, count(typecontrat) as nb "
                    + "from ( "
                    + "    select exp.idetudiant, min(debut) as datedeb "
                    + "    from alumni.experience exp "
                    + "    group by exp.idetudiant "
                    + ") x  "
                    + "inner join alumni.experience as e "
                    + "on e.idetudiant = x.idetudiant and e.debut = x.datedeb "
                    + "WHERE typecontrat != 'stage' "
                    + "group by typecontrat").list();
            HashMap<String, Integer> countContrats = new HashMap<String, Integer>();
            for (Object[] contrat : contrats) {
                countContrats.put((String) contrat[0], (Integer) contrat[1]);
            }
            return countContrats;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Double> getSalaires(Boolean embauche) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            String attr = "min";
            if (!embauche) {
                attr = "max";
            }
            ArrayList<Integer> listExperience = (ArrayList<Integer>) session.createSQLQuery("select e.IDEXPERIENCE from ( select exp.idetudiant, " + attr + "(debut) as datedeb from alumni.experience exp group by exp.idetudiant ) x inner join alumni.experience as e on e.idetudiant = x.idetudiant and e.debut = x.datedeb WHERE e.typecontrat != 'stage'").list();
            ArrayList<Double> listSalaire = new ArrayList();
            for (Integer id : listExperience) {
                Double val = (Double) session.createSQLQuery("select s.valeur from alumni.SALAIRE s where s.IDEXPERIENCE = " + id + " and s.annee = ( select min(annee) from alumni.salaire s where s.IDEXPERIENCE = " + id + ")").uniqueResult();
                if (val != null) {
                    listSalaire.add(val);
                }
            }
            return listSalaire;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Etudiant> getEtudiantAnnee(Integer annee) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Etudiant> result = null;
            List etu = session.createSQLQuery("select e.idetudiant, e.NOM, e.PRENOM,e.MAIL,e.MDP,e.ADRESSE,e.TELEPHONE,e.DATENAISSANCE,e.PHOTOPROFIL,e.CV,e.SOUHAITEEMPLOI,e.VALIDATION from ALUMNI.ANNEEDEFORMATION as adf, ALUMNI.ETUDIANT as e, ALUMNI.ETUDIANTANNEE as ea where adf.anneeuniversitairedebut=" + annee + " AND lower(adf.libelle) like '%miage sorbonne%' AND e.IDETUDIANT=ea.IDETUDIANT AND ea.IDFORMATION=adf.IDFORMATION").addEntity(Etudiant.class).list();
            result = (ArrayList<Etudiant>) etu;
            return result;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return null;

    }

    @Override
    public Competence getCompetence(String nom) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Competence comp = (Competence) session.createSQLQuery("SELECT DISTINCT libelle FROM Competence as c WHERE lower(c.libelle) ='" + nom.toLowerCase() + "'").uniqueResult();
            return comp;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Etudiant> getEtudiantNonValides() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Etudiant> etu = (ArrayList<Etudiant>) session.createQuery("FROM Etudiant as c WHERE c.validation ='n'").list();
            return etu;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Contact> getContactNonValides() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Contact> etu = (ArrayList<Contact>) session.createQuery("FROM Contact as c WHERE c.validation ='n'").list();
            return etu;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public void invalidere(Integer identifiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            session.delete((Etudiant) session.load(Etudiant.class, identifiant));
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void validere(Integer identifiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Etudiant e = (Etudiant) session.get(Etudiant.class, identifiant);
            e.setValidation("y");
            session.update(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
        }
    }

    @Override
    public void invaliderc(Integer identifiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            session.delete((Contact) session.load(Contact.class, identifiant));
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void validerc(Integer identifiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Contact e = (Contact) session.get(Contact.class, identifiant);
            e.setValidation("y");
            session.update(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
        }
    }

    @Override
    public void addAdministrateur(String nom, String prenom, String mail, String mdp) {
        try {
            Administrateur e = new Administrateur();
            e.setNom(nom);
            e.setPrenom(prenom);
            e.setMail(mail);
            e.setMdp(mdp);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(e);
            session.refresh(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public ArrayList<Administrateur> getAdministrateur() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Administrateur> listeComp = (ArrayList<Administrateur>) session.createQuery("FROM Administrateur").list();
            return listeComp;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Entreprise> getEntrepriseContactNV() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Entreprise> e = (ArrayList<Entreprise>) session.createSQLQuery("SELECT * FROM alumni.entreprise as e, alumni.contact as c where e.identreprise = c.identreprise and c.VALIDATION = 'n'").addEntity(Entreprise.class).list();
            if (e != null) {
            }
            return e;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Etudiant> getEtudiantsAnnuairePrive(Integer debut) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            ArrayList<Etudiant> results = new ArrayList();
            transaction = session.beginTransaction();
            Query q = session.createQuery("FROM Etudiant as e WHERE e.validation='y' AND e.souhaiteemploi='y'");
            q.setFirstResult(debut);
            q.setMaxResults(10);
            results = (ArrayList<Etudiant>) q.list();
            return results;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Etudiant> getEtudiantAnneePrive(Integer annee) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<Etudiant> result = null;
            List etu = session.createSQLQuery("select e.idetudiant, e.NOM, e.PRENOM,e.MAIL,e.MDP,e.ADRESSE,e.TELEPHONE,e.DATENAISSANCE,e.PHOTOPROFIL,e.CV,e.SOUHAITEEMPLOI,e.VALIDATION from ALUMNI.ANNEEDEFORMATION as adf, ALUMNI.ETUDIANT as e, ALUMNI.ETUDIANTANNEE as ea where adf.anneeuniversitairedebut=" + annee + " AND lower(adf.libelle) like '%miage sorbonne%' AND e.IDETUDIANT=ea.IDETUDIANT AND ea.IDFORMATION=adf.IDFORMATION AND e.souhaiteemploi='y'").addEntity(Etudiant.class).list();
            result = (ArrayList<Etudiant>) etu;
            return result;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    @Override
    public Long countEtudiantsPrive() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Long result = (Long) session.createQuery("select count(*) FROM Etudiant as e WHERE e.validation='y' AND e.souhaiteemploi='y'").uniqueResult();
            return result;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<String> getDistinctCompetences() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<String> listeComp = (ArrayList<String>) session.createSQLQuery("SELECT DISTINCT(libelle) FROM ALUMNI.COMPETENCE").list();
            return listeComp;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public void addExperience(int idEtudiant, int idEntreprise, String typeContrat, Date dateDebut, Date dateFin, String poste) {
        try {
            Experience e = new Experience();
            e.setIdetudiant(idEtudiant);
            e.setIdentreprise(idEntreprise);
            e.setTypecontrat(typeContrat);
            e.setDebut(dateDebut);
            e.setFin(dateFin);
            e.setIntituleposte(poste);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void updateEtudiant(Integer idetudiant, String nom, String prenom, String mail, String mdp, String telephone, String adresse, Date datenaiss, String profil, String cv, String souhait) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Etudiant e = (Etudiant) session.get(Etudiant.class, idetudiant);
            e.setNom(nom);
            e.setPrenom(prenom);
            e.setAdresse(adresse);
            e.setMail(mail);
            e.setMdp(mdp);
            e.setTelephone(telephone);
            e.setDatenaissance(datenaiss);
            e.setPhotoprofil(profil);
            e.setCv(cv);
            e.setSouhaiteemploi(souhait);
            session.update(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public Map getTypeContrat(Boolean embauche) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            String attr = "min";
            if (!embauche) {
                attr = "max";
            }
            List<Object[]> contrats = session.createSQLQuery("select typecontrat, count(typecontrat) as nb "
                    + "from ( "
                    + "    select exp.idetudiant, " + attr + "(debut) as datedeb "
                    + "    from alumni.experience exp "
                    + "    group by exp.idetudiant "
                    + ") x  "
                    + "inner join alumni.experience as e "
                    + "on e.idetudiant = x.idetudiant and e.debut = x.datedeb "
                    + "WHERE typecontrat != 'stage' "
                    + "group by typecontrat").list();
            HashMap<String, Integer> countContrats = new HashMap<String, Integer>();
            for (Object[] contrat : contrats) {
                countContrats.put((String) contrat[0], (Integer) contrat[1]);
            }
            return countContrats;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList getSalairesAvecEtudiant(Boolean embauche) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            String attr = "min";
            if (!embauche) {
                attr = "max";
            }
            // Récupère la liste des dernières expériences avec l'étudiant associé
            ArrayList<Object[]> listExperienceAvecEtudiant = (ArrayList<Object[]>) session.createSQLQuery("select e.IDEXPERIENCE, etu.IDETUDIANT, etu.PRENOM, etu.NOM, e.INTITULEPOSTE from alumni.etudiant etu, ( select exp.idetudiant, " + attr + "(debut) as datedeb from alumni.experience exp group by exp.idetudiant ) x inner join alumni.experience as e on e.idetudiant = x.idetudiant and e.debut = x.datedeb WHERE e.typecontrat != 'stage' AND e.IDETUDIANT = etu.IDETUDIANT").list();

            // On fait le trie pour ordonner la liste de sortie de la façon suivante : idEtudiant|nomEtudiant|prenomEtudiant|poste|salaireEtudiant
            ArrayList listSalaireAvecEtudiant = new ArrayList();
            ArrayList al_tmp = null;
            for (Object[] obj : listExperienceAvecEtudiant) {
                al_tmp = new ArrayList();
                // On récupère l'idExperience qui va nous servir à récupèrer le salaire
                Integer idExperience_tmp = (Integer) obj[0];

                // On récupère l'idEtudiant, nomEtudiant, prenomEtudiant, poste le salaire à l'embauche ou actuel dans la liste avec le salaire
                al_tmp.add(obj[1]);
                al_tmp.add(obj[2]);
                al_tmp.add(obj[3]);
                al_tmp.add(obj[4]);
                Double val = (Double) session.createSQLQuery("select s.valeur from alumni.SALAIRE s where s.IDEXPERIENCE = " + idExperience_tmp + " and s.annee = ( select min(annee) from alumni.salaire s where s.IDEXPERIENCE = " + idExperience_tmp + ")").uniqueResult();
                if (val != null) {
                    al_tmp.add(val);
                }
                listSalaireAvecEtudiant.add(al_tmp);
            }
            return listSalaireAvecEtudiant;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
    
    @Override
    public void addAnneeFormation(Integer anneedeb, Integer anneefin, String ecole, String libelle) {
        try {
            Anneedeformation e = new Anneedeformation();
            e.setAnneeuniversitairedebut(anneedeb);
            e.setAnneeuniversitairefin(anneefin);
            e.setEcole(ecole);
            e.setLibelle(libelle);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(e);
            session.refresh(e);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void updateEtudiant(Etudiant etudiant) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.update(etudiant);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void addSalaire(Integer idExperience, Double valeur, Integer annee) {
        try {
            Salaire s = new Salaire();
            s.setIdexperience(idExperience);
            s.setValeur(valeur);
            s.setAnnee(annee);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(s);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void addCompetence(Integer idExperience, String libelle) {
        try {
            Competence c = new Competence();
            c.setIdexperience(idExperience);
            c.setLibelle(libelle);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(c);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public Experience searchExperience(Integer idExperience) {
        try {
            transaction = session.beginTransaction();
            Experience e = (Experience) session.createQuery("FROM Experience AS e WHERE e.idexperience = " + idExperience).uniqueResult();
            return e;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public void deleteExperience(Experience exp) {
        try {
            transaction = session.beginTransaction();
            session.delete(exp);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public Integer addExperience(Integer idEtudiant, Integer idEntreprise, String typeContrat, Date dateDebut, Date dateFin, String poste) {
        try {
            Experience e = new Experience();
            e.setIdetudiant(idEtudiant);
            e.setIdentreprise(idEntreprise);
            e.setTypecontrat(typeContrat);
            e.setDebut(dateDebut);
            e.setFin(dateFin);
            e.setIntituleposte(poste);
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(e);
            session.getTransaction().commit();
            return e.getIdexperience();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return 0;
        }
    }

    @Override
    public ArrayList<String> getDistinctLibellesFormation() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<String> listeLibelle = (ArrayList<String>) session.createSQLQuery("SELECT DISTINCT(libelle) FROM ALUMNI.ANNEEDEFORMATION").list();
            return listeLibelle;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList<String> getDistinctEcoleFormation() {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            ArrayList<String> listeEcole = (ArrayList<String>) session.createSQLQuery("SELECT DISTINCT(ecole) FROM ALUMNI.ANNEEDEFORMATION").list();
            return listeEcole;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public String getLibelleFormation(String nom) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            String libelle = (String) session.createSQLQuery("SELECT DISTINCT libelle FROM ALUMNI.ANNEEDEFORMATION as af WHERE lower(af.libelle) ='" + nom.toLowerCase() + "'").uniqueResult();
            return libelle;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public String getEcoleFormation(String nom) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            String ecole = (String) session.createSQLQuery("SELECT DISTINCT ecole FROM ALUMNI.ANNEEDEFORMATION as af WHERE lower(af.ecole) ='" + nom.toLowerCase() + "'").uniqueResult();
            return ecole;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public Anneedeformation searchFormation(Integer idFormation) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            Anneedeformation af = (Anneedeformation) session.createQuery("FROM Anneedeformation AS af WHERE af.idformation = " + Integer.valueOf(idFormation)).uniqueResult();
            return af;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    @Override
    public void removeAnneeEtudiantFormation(Integer idEtudiant, Integer idFormation) {
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
            EtudiantanneeId  etId= new EtudiantanneeId();
            etId.setIdetudiant(idEtudiant);
            etId.setIdformation(idFormation);
            
            session.delete(etId);
          //  System.out.println("DELETE FROM ALUMNI.ETUDIANTANNEE  as ae WHERE ae.idformation="+idFormation+ " AND ae.idetudiant="+idEtudiant);
          //  session.createSQLQuery("DELETE FROM ALUMNI.ETUDIANTANNEE  as ae WHERE ae.idformation="+idFormation+ " AND ae.idetudiant="+idEtudiant);
            session.getTransaction().commit();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
