/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.Salaire;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.action.DynaActionForm;

/**
 *
 * @author Desvides
 */
public class Experience extends SuperAction {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String ECHEC = "echec";

    public Experience() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        super();
        f.instantiate("com.alumni.model.dao.AlumniService");
    }

    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Etudiant etudiant = (Etudiant) request.getSession().getAttribute("etudiant");
        // On vérifie qu'une session est bien présente
        if (etudiant == null) {
            return mapping.findForward(ECHEC);
        }

        DynaActionForm expForm = (DynaActionForm) form;
        // Récupération des données envoyées par la personne
        String typeContrat = expForm.getString("typecontrat");
        String debut = expForm.getString("debut");
        String fin = expForm.getString("fin");
        String intituleposte = expForm.getString("intituleposte");
        String nomentreprise = expForm.getString("nomentreprise");
        String listeComp = expForm.getString("listeComp");
        String adresseEntreprise = expForm.getString("adresseEntreprise");
        Salaire[] salaireLines = (Salaire[]) expForm.get("salaire");

        //Création des erreurs
        ActionMessages errors = new ActionMessages();
        boolean debutEntered = false;

        /**
         * Différents tests sur les données envoyées par l'utilisateur
         */
        // Vérification sur la date de début et la date de fin
        if (!debut.isEmpty()) {
            debutEntered = true;
        }
        Date dateDebut = new Date();
        Date dateFin = new Date();

        if (debutEntered) {
            if (!Alumni.verificationDate(debut)) {
                errors.add("errorMessage", new ActionMessage("error.date.format"));
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dateDebut = sdf.parse(debut);
                // On effectue des vérifications sur la date de fin, que si la date de début de l'expérience est précisée
                if (!fin.isEmpty()) {
                    if (!Alumni.verificationDate(fin)) {
                        errors.add("errorMessage", new ActionMessage("error.date.format"));
                    } else {
                        dateFin = sdf.parse(fin);
                        // Si la dateFin se trouve avant la dateDebut
                        if (!dateFin.after(dateDebut)) {
                            errors.add("errorMessage", new ActionMessage("error.date.avant"));
                        }
                    }
                }
            }
        } else {
            errors.add("errorMessage", new ActionMessage("error.date.debutExp"));
        }

        // Vérification concernant le type de contrat
        if (typeContrat.equals("0")) {
            errors.add("errorMessage", new ActionMessage("error.typeContrat"));
        }

        // Vérification sur l'intitulé du poste
        if (intituleposte.isEmpty()) {
            errors.add("errorMessage", new ActionMessage("error.intituleposte"));
        }

        // Vérification sur l'entreprise
        if (nomentreprise.isEmpty()) {
            errors.add("errorMessage", new ActionMessage("error.nomentreprise.missing"));
        }

        if (errors.isEmpty()) {
            // Début des traitements       
            Entreprise entre = null;
            Object[] paramGetEntreprise = {nomentreprise};
            entre = (Entreprise) f.lancerMethode(paramGetEntreprise, "getEntreprise");
            // Création si nécessaire de l'entreprise
            int idEntreprise;
            if (entre == null) {
                Object[] paramAddEntreprise = {nomentreprise, adresseEntreprise};
                idEntreprise = (Integer) f.lancerMethode(paramAddEntreprise, "addEntreprise");
            } else {
                idEntreprise = entre.getIdentreprise();
            }

            // Insertion en bdd pour Entreprise
            Object[] paramAddExperience = {etudiant.getIdetudiant(), idEntreprise, typeContrat, dateDebut, dateFin, intituleposte};
            int idExperience = (Integer) f.lancerMethode(paramAddExperience, "addExperience");

            if (idExperience != 0) {
                int i = 0;
                // Partie concernant les salaires
                while (i < salaireLines.length) {
                    // Afin de ne pas parcourir tout le tab Salaire
                    if (salaireLines[i].getValeur() == null) {
                        break;
                    }
                    if (salaireLines[i].getAnnee() != 0 && !salaireLines[i].getValeur().equals("Montant")) {
                        Object[] paramAddSalaire = {idExperience, salaireLines[i].getValeur(), salaireLines[i].getAnnee()};
                        f.lancerMethode(paramAddSalaire, "addSalaire");
                    }
                    i++;
                }

                // Partie concernant les compétences
                String[] liste = listeComp.split(";");

                for (String competence : liste) {
                    Object[] paramAddSalaire = {idExperience,competence};
                    f.lancerMethode(paramAddSalaire, "addCompetence");
                }
            }


            // Redirection vers la bonne page
            return mapping.findForward(SUCCESS);
        }
        saveErrors(request, errors);
        return mapping.findForward(ECHEC);
    }
}
