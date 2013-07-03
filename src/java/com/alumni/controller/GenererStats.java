package com.alumni.controller;

import com.alumni.util.Export;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class GenererStats extends SuperAction {

    public GenererStats() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        super();
        f.instantiate("com.alumni.model.dao.AlumniService");
    }

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Map competencesToutPeriode = (Map) f.lancerMethode(null, "getCountCompetences");
        request.setAttribute("competences", competencesToutPeriode);
        Map competencesStage = (Map) f.lancerMethode(null, "getCountCompetencesStage");
        request.setAttribute("competencesStage", competencesStage);
        Map competencesEmploi = (Map) f.lancerMethode(null, "getCountCompetencesEmploi");
        request.setAttribute("competencesEmploi", competencesEmploi);


        Map contratsToutePeriode = (Map) f.lancerMethode(null, "getCountTypesContrat");
        request.setAttribute("contrats", contratsToutePeriode);



        /**
         * Récupération embauche
         */
        Boolean embauche = true;
        Object[] isEmbauche = {embauche};
        // Contrat embauche
        Map contratsEmbauche = (Map) f.lancerMethode(isEmbauche, "getTypeContrat");
        // Salaire embauche
        ArrayList listSalaireEmbaucheEtudiant = (ArrayList) f.lancerMethode(isEmbauche, "getSalairesAvecEtudiant");

        /**
         * Récupération non embauche
         */
        embauche = false;
        Object[] isNotEmbauche = {embauche};
        // Contrat actuel
        Map contratsActuel = (Map) f.lancerMethode(isNotEmbauche, "getTypeContrat");
        // Salaire actuel
        ArrayList listSalaireActuelEtudiant = (ArrayList) f.lancerMethode(isNotEmbauche, "getSalairesAvecEtudiant");



        Export xp = new Export("miage-competences.xlsx");
        xp.createFeuille2CI("Toute période", "Compétences", new ArrayList<String>(competencesToutPeriode.keySet()), "Quantité", new ArrayList<Integer>(competencesToutPeriode.values()));
        xp.createFeuille2CI("Emploi", "Compétences", new ArrayList<String>(competencesEmploi.keySet()), "Quantité", new ArrayList<Integer>(competencesEmploi.values()));
        xp.createFeuille2CI("Stage", "Compétences", new ArrayList<String>(competencesStage.keySet()), "Quantité", new ArrayList<Integer>(competencesStage.values()));
        xp.finishExcel();

        xp = new Export("miage-typecontrat.xlsx");
        xp.createFeuille2CI("Toute période", "Type de contrat", new ArrayList<String>(contratsToutePeriode.keySet()), "Quantité", new ArrayList<Integer>(contratsToutePeriode.values()));
        xp.createFeuille2CI("Embauche", "Type de contrat", new ArrayList<String>(contratsActuel.keySet()), "Quantité", new ArrayList<Integer>(contratsEmbauche.values()));
        xp.createFeuille2CI("Actuel", "Type de contrat", new ArrayList<String>(contratsActuel.keySet()), "Quantité", new ArrayList<Integer>(contratsActuel.values()));
        xp.finishExcel();

        xp = new Export("miage-salaire.xlsx");
        xp.createFeuilleSalaireEtudiant("Embauche", listSalaireEmbaucheEtudiant);
        xp.createFeuilleSalaireEtudiant("Actuel", listSalaireActuelEtudiant);
        xp.finishExcel();

        return mapping.getInputForward();
    }
}
