/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Anneedeformation;
import com.alumni.mapping.Etudiant;
import java.util.Date;
import java.util.Set;
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
 * @author Gregory
 */
public class Formation extends SuperAction {
    /* forward name="success" path="" */

    private static final String SUCCESS = "success";
    private static final String ECHEC = "echec";

    public Formation() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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
        //Création des erreurs
        ActionMessages errors = new ActionMessages();
        // Récupération des données envoyées 
        String debut = expForm.getString("anneedeb");
        String fin = expForm.getString("anneefin");
        String ecole = expForm.getString("ecole");
        String libelle = expForm.getString("libelle");
        Integer ad = null;
        Integer af = null;

        try {
            ad = Integer.valueOf(debut);
            af = Integer.valueOf(fin);
        } catch (Exception ex) {
            errors.add("errorMessage", new ActionMessage("error.format.date"));
            saveErrors(request, errors);
            return mapping.findForward(ECHEC);
        }

        Set anneesFormationEtu = etudiant.getAnneeformation();
        Anneedeformation anneeFormation = new Anneedeformation();
        // Set des information de l'année de formation
        anneeFormation.setAnneeuniversitairedebut(ad);
        anneeFormation.setAnneeuniversitairefin(af);
        anneeFormation.setEcole(ecole);
        anneeFormation.setLibelle(libelle);
        // Ajout de l'année de formation aux années de formations étudiant
        anneesFormationEtu.add(anneeFormation);
        
        etudiant.setAnneeformation(anneesFormationEtu);

        Object[] paramUpdateEtudiant = {etudiant};
        f.lancerMethode(paramUpdateEtudiant, "updateEtudiant");

        /* 
         Object[] params = {ad, af, ecole, libelle};
         f.lancerMethode(params, "addAnneeFormation");
         */
        return mapping.findForward(SUCCESS);


    }
}
