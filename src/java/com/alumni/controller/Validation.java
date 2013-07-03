package com.alumni.controller;

import com.alumni.mapping.Contact;
import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessages;

public class Validation extends SuperAction {

    private static final String SUCCESS = "success";
    private static final String ECHEC = "echec";

    public Validation() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        super();
        f.instantiate("com.alumni.model.dao.AlumniService");
    }

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        //Création des erreurs
        ActionMessages errors = new ActionMessages();

        if (request.getParameter("action") != null) {
            if (request.getParameter("type").equals("etudiant")) {
                if (request.getParameter("action").equals("valider")) {
                    Object[] param = {Integer.valueOf(request.getParameter("id"))};
                    f.lancerMethode(param, "validere");
                } else if (request.getParameter("action").equals("invalider")) {
                    Object[] param = {Integer.valueOf(request.getParameter("id"))};
                    f.lancerMethode(param, "invalidere");
                }
            } else if (request.getParameter("type").equals("contact")) {
                if (request.getParameter("action").equals("valider")) {
                    Object[] param = {Integer.valueOf(request.getParameter("id"))};
                    f.lancerMethode(param, "validerc");
                } else if (request.getParameter("action").equals("invalider")) {
                    Object[] param = {Integer.valueOf(request.getParameter("id"))};
                    f.lancerMethode(param, "invaliderc");
                }
            }
        }
        ArrayList<Etudiant> etudiants = (ArrayList<Etudiant>) f.lancerMethode(null, "getEtudiantNonValides");
        request.setAttribute("nonvalides", etudiants);
        ArrayList<Contact> contact = (ArrayList<Contact>) f.lancerMethode(null, "getContactNonValides");
        request.setAttribute("cnonvalides", contact);
        ArrayList<Entreprise> e = (ArrayList<Entreprise>) f.lancerMethode(null, "getEntrepriseContactNV");
        request.setAttribute("entreprises", (ArrayList<Entreprise>) f.lancerMethode(null, "getEntrepriseContactNV"));


        saveErrors(request, errors);
        // Redirection vers la page d'accueil
        return mapping.findForward(SUCCESS);
    }
}
