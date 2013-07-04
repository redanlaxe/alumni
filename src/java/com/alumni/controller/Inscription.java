package com.alumni.controller;

import com.alumni.mapping.Contact;
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

public class Inscription extends SuperAction {

	private static final String SUCCESS = "success";
	private static final int TAILLE_MAX_FICHIER = 2000000;

	public Inscription() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
		super();
		f.instantiate("com.alumni.model.dao.AlumniService");
	}

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		DynaActionForm inscriptionForm = (DynaActionForm) form;

		// Récupération des données envoyées par la personne
		String nom = inscriptionForm.getString("nom");
		String prenom = inscriptionForm.getString("prenom");
		String mail = inscriptionForm.getString("mail");
		String mdp = inscriptionForm.getString("mdp");
		String telephone = inscriptionForm.getString("telephone");
		String typeCompte = inscriptionForm.getString("compte");


		/**
		 * Champs variable selon les formulaires
		 */
		String adresse = null;
		String date = null;
		String photoProfil = null;
		String souhaiteEmploi = null;
		String poste = null;
		String nomEntreprise = null;
		String adresseEntreprise = null;
		if (typeCompte.contains("etudiant")) {
			/**
			 * Spécifique étudiant
			 */
			adresse = inscriptionForm.getString("adresse");
			date = inscriptionForm.getString("dateNaissance");
			souhaiteEmploi = (String) inscriptionForm.get("souhaiteEmploi");
			if (souhaiteEmploi.isEmpty()) {
				souhaiteEmploi = "n";
			}
		} else {
			/**
			 * Spécifique entreprise
			 */
			poste = inscriptionForm.getString("poste");
			nomEntreprise = inscriptionForm.getString("entreprise");
			adresseEntreprise = inscriptionForm.getString("adresseEntreprise");
		}


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
		if (typeCompte.equals("etudiant")) {
			p = (Etudiant) f.lancerMethode(param, "searchCompte");
		} else if (typeCompte.equals("entreprise")) {
			p = (Contact) f.lancerMethode(param, "searchCompte");
		}
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
		ActionMessages messages = new ActionMessages();
		if (typeCompte.equals("etudiant")) {
			// Vérification sur la date de naissance
			if (!date.isEmpty()) {
				dateNaissanceEntered = true;
			}
			Date dateNaissance = new Date();
			if (dateNaissanceEntered) {
				if (!Alumni.verificationDate(date)) {
					errors.add("errorMessage", new ActionMessage("error.date.format"));
				} else {
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
					sdf.applyPattern("yyyy-MM-dd");
					dateNaissance = sdf.parse(date);
				}
			}

			if (errors.isEmpty()) {
				Object[] paramAddEtu = {nom, prenom, mail, Alumni.sha1(mdp), telephone, adresse, dateNaissance, "test", "test", souhaiteEmploi};
				f.lancerMethode(paramAddEtu, "addEtudiant");
				messages.add("appMessage", new ActionMessage("inscription.successfull"));
				saveMessages(request, messages);
			}
		} else if (typeCompte.equals("entreprise")) {
			boolean entrepriseExist = false;
			Entreprise entre = null;
			if (nomEntreprise.isEmpty()) {
				errors.add("errorMessage", new ActionMessage("error.nomentreprise.missing"));
			} else {
				Object[] paramGetEntreprise = {nomEntreprise};
				entre = (Entreprise) f.lancerMethode(paramGetEntreprise, "getEntreprise");
				if (entre == null) {
					Object[] paramAddEntreprise = {nomEntreprise, adresseEntreprise};
					int idEntreprise = (Integer) f.lancerMethode(paramAddEntreprise, "addEntreprise");
					entre = new Entreprise(idEntreprise, nomEntreprise, adresseEntreprise);
				}
			}
			if (errors.isEmpty()) {
				// Insertion en bdd pour Entreprise
				Object[] paramAddContact = {nom, prenom, mail, Alumni.sha1(mdp), telephone, poste, entre.getIdentreprise()};
				f.lancerMethode(paramAddContact, "addContactEntreprise");
				messages.add("appMessage", new ActionMessage("inscription.successfull"));
				saveMessages(request, messages);
			}
		}
		if (!errors.isEmpty()) {
			// Redirection vers la page d'inscription
			saveErrors(request, errors);
			return mapping.getInputForward();
		}
		return mapping.findForward(SUCCESS);
	}
}