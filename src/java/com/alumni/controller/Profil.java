/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Administrateur;
import com.alumni.mapping.Competence;
import com.alumni.mapping.Contact;
import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.Experience;
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
 * @author Dimitri
 */
public class Profil extends SuperAction {
    /* forward name="success" path="" */

    private static final String SUCCESS_me = "success";
    private static final String SUCCESS_show = "success_show";
    private static final String ECHEC = "echec";

    public Profil() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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
        String redict = SUCCESS_me;
        Etudiant etudiant = (Etudiant) request.getSession().getAttribute("etudiant");
        Contact contact = (Contact) request.getSession().getAttribute("contact");
        Administrateur admin = (Administrateur) request.getSession().getAttribute("admin");
        // On vérifie qu'une session est bien présente
        if (etudiant == null && contact == null && admin == null) {
            return mapping.findForward(ECHEC);
        }

        // On regarde si c'est un profil vu par une autre personne
        String id = request.getParameter("id");
        if (id != null) {
            Object[] paramGetEtudiant = {id};
            Etudiant e = (Etudiant) f.lancerMethode(paramGetEtudiant, "searchEtudiantById");
            etudiant = e;
            request.setAttribute("etudiant_show", e);
            redict = SUCCESS_show;
        }
        Object[] param = {etudiant.getIdetudiant()};

        Set anneesformation = etudiant.getAnneeformation();

        ArrayList<Experience> experiences = (ArrayList<Experience>) f.lancerMethode(param, "getExperienceEtudiant");


        ArrayList<Salaire> salaires = new ArrayList<Salaire>();
        ArrayList<Competence> competences = new ArrayList<Competence>();
        Set<Entreprise> entreprises = new HashSet<Entreprise>();
        if (experiences != null) {
            for (Experience exp : experiences) {
                Object[] paramExp = {exp.getIdexperience()};

                salaires.addAll((ArrayList<Salaire>) f.lancerMethode(paramExp, "getSalaireExperience"));

                competences.addAll((ArrayList<Competence>) f.lancerMethode(paramExp, "getCompetenceExperience"));

                Object[] paramEnt = {exp.getIdentreprise()};
                entreprises.add((Entreprise) f.lancerMethode(paramEnt, "getEntrepriseExperience"));

            }
        }
        request.setAttribute("anneesformation", anneesformation);
        request.setAttribute("experiences", experiences);
        request.setAttribute("salaires", salaires);
        request.setAttribute("competences", competences);
        request.setAttribute("entreprises", entreprises);

        return mapping.findForward(redict);
    }
}
