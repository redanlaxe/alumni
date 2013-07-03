/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller;

import com.alumni.mapping.Entreprise;
import com.alumni.mapping.Etudiant;
import com.alumni.mapping.Personne;
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
import org.apache.struts.upload.FormFile;

/**
 *
 * @author Desvides
 */
public class ModifProfil extends SuperAction {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String ECHEC = "echec";
    private static final int TAILLE_MAX_FICHIER = 2000000;

    public ModifProfil() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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
        DynaActionForm modifProfilForm = (DynaActionForm) form;
        Etudiant etudiant = (Etudiant) request.getSession().getAttribute("etudiant");
        // On vérifie qu'une session est bien présente
        if (etudiant == null) {
            return mapping.findForward(ECHEC);
        }
        // Récupération des données envoyées par la personne
        String nom = modifProfilForm.getString("nom");
        String prenom = modifProfilForm.getString("prenom");
        String mail = modifProfilForm.getString("mail");
        String mdp = modifProfilForm.getString("mdp");
        String telephone = modifProfilForm.getString("telephone");
        String adresse = modifProfilForm.getString("adresse");
        String date = modifProfilForm.getString("dateNaissance");
        FormFile photoProfil = (FormFile) modifProfilForm.get("photoProfil");
        FormFile cv = (FormFile) modifProfilForm.get("cv");
        String souhaiteEmploi = (String) modifProfilForm.get("souhaiteEmploi");

        //Création des erreurs
        ActionMessages errors = new ActionMessages();
        boolean mailEntered = false;
        boolean dateNaissanceEntered = false;

        /**
         * Vérification nom & prenom
         */
        if (prenom.isEmpty()) {
            errors.add("errorMessage", new ActionMessage("error.prenom.absent"));
        }
        if (nom.isEmpty()) {
            errors.add("errorMessage", new ActionMessage("error.nom.absent"));
        }


        /**
         * Vérification email
         */
        if (!mail.isEmpty()) {
            mailEntered = true;
        } else {
            errors.add("errorMessage", new ActionMessage("error.mail.absent"));
        }
        if (mailEntered && !Alumni.verificationMail(mail)) {
            errors.add("errorMessage", new ActionMessage("error.mail.format"));
        }
        Object[] param = {mail};
        Personne p = null;

        p = (Etudiant) f.lancerMethode(param, "searchCompte");

        if (p != null) {
            errors.add("errorMessage", new ActionMessage("error.mail.existant"));
        }

        /**
         * Vérfication mot de passe
         */
        if (mdp.isEmpty()) {
            errors.add("errorMessage", new ActionMessage("error.mdp.absent"));
        } else if (mdp.length() < 6) {
            errors.add("errorMessage", new ActionMessage("error.mdp.court"));
        }


        /**
         * Vérification téléphone
         */
        if (!telephone.isEmpty() && !Alumni.verificationTelephone(telephone)) {
            errors.add("errorMessage", new ActionMessage("error.telephone.format"));
        }


        /**
         * Début traitement
         */
        // Vérification sur la date de naissance
        if (!date.isEmpty()) {
            dateNaissanceEntered = true;
        }
        Date dateNaissance = new Date();
        if (dateNaissanceEntered) {
            if (!Alumni.verificationDate(date)) {
                errors.add("errorMessage", new ActionMessage("error.date.format"));
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dateNaissance = sdf.parse(date);
            }
        }

        if (errors.isEmpty()) {
            Object[] paramAddEtu = {etudiant.getIdetudiant(), nom, prenom, mail, Alumni.sha1(mdp), telephone, adresse, dateNaissance, photoProfil.getFileName(), cv.getFileName(), souhaiteEmploi};
            f.lancerMethode(paramAddEtu, "updateEtudiant");
        }

        if (!errors.isEmpty()) {
            // Redirection vers la page d'inscription
            saveErrors(request, errors);
            return mapping.getInputForward();
            //return mapping.findForward(ECHEC);
        }
        return mapping.getInputForward();
        //return mapping.findForward(SUCCESS);
    }
}