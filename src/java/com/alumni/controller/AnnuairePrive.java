/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Etudiant;
import java.util.ArrayList;
import java.util.List;
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
public class AnnuairePrive extends SuperAction {

    private static final String SUCCESS = "success";
    private static final String ECHEC = "echec";

    public AnnuairePrive() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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

        //Création des erreurs
        ActionMessages errors = new ActionMessages();
        DynaActionForm formulaire = (DynaActionForm) form;
        String anneedeb = formulaire.getString("anneedeb");
        ArrayList<Etudiant> etudiants = null;

        try {
            Integer.valueOf(anneedeb);
        } catch (Exception ex) {
            if (!anneedeb.equals("")) {
                errors.add("errorMessage", new ActionMessage("error.champs.incorrect"));
            }
        }

        if (errors.isEmpty()) {
            if (!anneedeb.equals("")) {
                Object[] param = {Integer.valueOf(anneedeb)};
                etudiants = (ArrayList<Etudiant>) f.lancerMethode(param, "getEtudiantAnneePrive");
                request.setAttribute("etudiants", etudiants);
                return mapping.findForward(SUCCESS);
            } else {
                Long totalEtudiant = (Long) f.lancerMethode(null, "countEtudiantsPrive");
                Double totalPage = totalEtudiant.doubleValue() / 10;
                List<Integer> totalPages = new ArrayList<Integer>();
                for (int i = 0; i < totalPage; i++) {
                    totalPages.add(i);
                }
                Integer laLimite = new Integer(0);
                String p = request.getParameter("p");
                if (p != null) {
                    laLimite = Integer.valueOf(p) * 10;
                }
                Object[] limit = {laLimite};
                etudiants = (ArrayList<Etudiant>) f.lancerMethode(limit, "getEtudiantsAnnuairePrive");
                request.setAttribute("etudiantsp", etudiants);
                request.setAttribute("nbPage", totalPages);
                return mapping.findForward(SUCCESS);
            }

        }
        saveErrors(request, errors);
        // Redirection vers la page d'accueil
        return mapping.findForward(ECHEC);
    }
}
