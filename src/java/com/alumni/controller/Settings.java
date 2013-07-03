/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Anneedeformation;
import com.alumni.mapping.Competence;
import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.Personne;
import com.alumni.mapping.Salaire;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Desvides
 */
public class Settings extends SuperAction {

    /* forward name="success" path="" */
    private static final String UPDATE_EXP = "update_exp";
    private static final String UPDATE_FORM = "update_form";
    private static final String ECHEC = "echec";
    private static final String DELETE = "delete";

    public Settings() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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

        int idExp, idFor, idEtu;

        // On regarde si c'est un profil vu par une autre personne
        String stringIdExp = request.getParameter("idExp");
        if (stringIdExp != null && !stringIdExp.isEmpty()) {
            idExp = Integer.valueOf(stringIdExp);
        } else {
            idExp = 0;
        }
        // On regarde si c'est un profil vu par une autre personne
        String stringIdForm = request.getParameter("idFor");
        if (stringIdForm != null && !stringIdForm.isEmpty()) {
            idFor = Integer.valueOf(stringIdForm);
        } else {
            idFor = 0;
        }
        // Action vaut 0 pour modif et 1 pour delete
        String action = request.getParameter("action");
        // idEtu pour comparer avec l'étudiant actuel
        String stringIdEtu = request.getParameter("idEtu");
        if (stringIdEtu != null && !stringIdEtu.isEmpty()) {
            idEtu = Integer.valueOf(stringIdEtu);
        } else {
            idEtu = 0;
        }
        // On vérifie que les deux paramètres sont présents
        if (idExp > 0) {
            if (action != null && idExp != 0) {
                Object[] paramSearchExp = {idExp};
                com.alumni.mapping.Experience exp = (com.alumni.mapping.Experience) f.lancerMethode(paramSearchExp, "searchExperience");
                if (exp != null) {
                    if (action.equals("d")) {
                        Object[] paramDelExp = {exp};
                        f.lancerMethode(paramDelExp, "deleteExperience");
                    }
                }
            }
        }
        // Partie concernant la formation
        if (idFor > 0) {
            if (action != null && idEtu == etudiant.getIdetudiant()) {
                Object[] paramSearchForm = {idFor};
                Anneedeformation annee = (Anneedeformation) f.lancerMethode(paramSearchForm, "searchFormation");
                // Cas de la modification
                if (action.equals("u")) {
                    request.setAttribute("anneeFormation", annee);
                    return mapping.findForward(UPDATE_FORM);
                } else {
                    // Cas de la suppression
                    if (action.equals("d")) {
                        
                        Object[] paramUpdateEtudiant = {idEtu, idFor};
                        f.lancerMethode(paramUpdateEtudiant, "removeAnneeEtudiantFormation");

                        Object[] param = {etudiant.getMail()};
                        Etudiant e = (Etudiant) f.lancerMethode(param, "searchCompte");
                        
                        request.getSession().setAttribute("etudiant", e);
                    }
                }
            }
        }


        // On retourne à la page profil (cas du delete et de l'expérience non trouvée)
        return mapping.findForward(DELETE);
    }
}
