package com.alumni.controller;

import com.alumni.util.Export;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Statistique extends SuperAction {

    public Statistique() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        super();
        f.instantiate("com.alumni.model.dao.AlumniServiceDAO");
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
        request.setAttribute("firstContrats", contratsEmbauche);
        // Salaire embauche
        ArrayList<Double> salaireEmbauche = (ArrayList<Double>) f.lancerMethode(isEmbauche, "getSalaires");
        request.setAttribute("salaireEmbauche", Alumni.moyenne(salaireEmbauche));

        /**
         * Récupération non embauche
         */
        embauche = false;
        Object[] isNotEmbauche = {embauche};
        // Contrat actuel
        Map contratsActuel = (Map) f.lancerMethode(isNotEmbauche, "getTypeContrat");
        request.setAttribute("lastContrats", contratsActuel);
        // Salaire actuel
        ArrayList<Double> salaireActuel = (ArrayList<Double>) f.lancerMethode(isNotEmbauche, "getSalaires");
        request.setAttribute("salaireActuel", Alumni.moyenne(salaireActuel));

        return mapping.getInputForward();
    }
}
