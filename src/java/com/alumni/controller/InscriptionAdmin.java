/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Administrateur;
import com.alumni.mapping.Etudiant;
import java.util.ArrayList;
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
public class InscriptionAdmin extends SuperAction {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAIL = "echec";

    public InscriptionAdmin() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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

        DynaActionForm formulaire = (DynaActionForm) form;
        ActionMessages errors = new ActionMessages();

        if (!formulaire.get("nom").equals("") && !formulaire.get("prenom").equals("") && !formulaire.get("mail").equals("") && !formulaire.get("mdp").equals("")) {
            String nom = formulaire.getString("nom");
            String prenom = formulaire.getString("prenom");
            String mail = formulaire.getString("mail");
            String mdp = formulaire.getString("mdp");
            mdp = Alumni.sha1(mdp);
            Object[] params = {nom, prenom, mail, mdp};
            f.lancerMethode(params, "addAdministrateur");
        } else if (!formulaire.get("nom").equals("") && !formulaire.get("prenom").equals("") && !formulaire.get("mail").equals("") && !formulaire.get("mdp").equals("")) {
        } else if (!formulaire.get("nom").equals("") || !formulaire.get("prenom").equals("") || !formulaire.get("mail").equals("") || !formulaire.get("mdp").equals("")) {
            errors.add("errorMessage", new ActionMessage("error.champs.vide"));
        }

        saveErrors(request, errors);
        Object[] param = {};
        ArrayList<Administrateur> administrateur = (ArrayList<Administrateur>) f.lancerMethode(param, "getAdministrateur");
        request.setAttribute("administrateurs", administrateur);
        return mapping.findForward(SUCCESS);
    }
}
