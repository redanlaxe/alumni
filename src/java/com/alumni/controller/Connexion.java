package com.alumni.controller;

import com.alumni.mapping.Administrateur;
import com.alumni.mapping.Contact;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.Personne;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.action.DynaActionForm;

public final class Connexion extends SuperAction {

    private static final String SUCCESS_ETUDIANT = "successEtudiant";
    private static final String SUCCESS_CONTACT = "successContact";
    private static final String SUCCESS_ADMIN = "successAdmin";
    private static final String ECHEC = "echec";

    public Connexion() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        super();
        f.instantiate("com.alumni.model.dao.AlumniService");
    }

    @Override
    public ActionForward execute(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {
        DynaActionForm connexionForm = (DynaActionForm) form;
        boolean idEntered = true;
        boolean mdpEntered = true;

        // Récupération des données envoyées par la personne
        String mail = connexionForm.getString("mail").trim();
        String mdp = connexionForm.getString("mdp").trim();

        //Création des erreurs
        ActionMessages errors = new ActionMessages();

        // Vérification sur l'identifiant
        if (mail.isEmpty()) {
            idEntered = false;
            errors.add("errorMessage", new ActionMessage("error.mail.absent"));
        }
        // Vérification sur le mot de passe
        if (mdp.isEmpty()) {
            mdpEntered = false;
            errors.add("errorMessage", new ActionMessage("error.mdp.absent"));
        }

        Object[] param = {mail};
        Personne p = (Personne) f.lancerMethode(param, "searchCompte");


        // Vérification sur l'existence de la personne, et du mot de passe associé
        if (mdpEntered && idEntered) {
            if (p == null) {
                errors.add("errorMessage", new ActionMessage("error.mail.inconnu"));
            }
            if (p != null && !p.getMdp().equals(Alumni.sha1(mdp))) {
                errors.add("errorMessage", new ActionMessage("error.mdp.incorrect"));
            }
        }

        if (errors.isEmpty()) {
            if (p instanceof Contact) {// Cas du contact entreprise
                Contact contact = (Contact) p;
                // On vérifie que le contact à un compte validé
                if (contact.getValidation().equals("y")) {
                    HttpSession mySession = request.getSession(false);
                    if (mySession != null) {
                        mySession.invalidate();
                    }
                    // Insertion du contact en session
                    request.getSession().setAttribute("contact", contact);
                    request.setAttribute("etudiants", f.lancerMethode(null, "getEtudiants"));
                    // Redirection vers la page annuaire
                    return mapping.findForward(SUCCESS_CONTACT);
                } else {
                    errors.add("errorMessage", new ActionMessage("error.compte.validation"));
                }
            } else if (p instanceof Etudiant) { // Cas de l'étudiant
                Etudiant etudiant = (Etudiant) p;
                // On vérifie que l'étudiant à un compte validé
                if (etudiant.getValidation().equals("y")) {
                    HttpSession mySession = request.getSession(false);
                    if (mySession != null) {
                        mySession.invalidate();
                    }
                    // Insertion de l'etudiant en session
                    request.getSession().setAttribute("etudiant", etudiant);
                    // Redirection vers la page profil
                    return mapping.findForward(SUCCESS_ETUDIANT);
                } else {
                    errors.add("errorMessage", new ActionMessage("error.compte.validation"));
                }
            } else { // Cas de l'admin
                Administrateur admin = (Administrateur) p;
                HttpSession mySession = request.getSession(false);
                if (mySession != null) {
                    mySession.invalidate();
                }
                // Insertion de l'admin en session
                request.getSession().setAttribute("admin", admin);
                // Redirection vers la page de gestion admin
                return mapping.findForward(SUCCESS_ADMIN);
            }
        }
        saveErrors(request, errors);
        // Redirection vers la page d'accueil
        return mapping.findForward(ECHEC);
    }
}
