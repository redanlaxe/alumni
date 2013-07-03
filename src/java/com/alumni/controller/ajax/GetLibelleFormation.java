/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller.ajax;

import com.alumni.controller.SuperAction;
import com.alumni.mapping.Anneedeformation;
import com.alumni.mapping.Entreprise;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Desvides
 */
public class GetLibelleFormation extends SuperAction {

    public GetLibelleFormation() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        super();
        f.instantiate("com.alumni.model.dao.AlumniService");
    }

    @Override
    public ActionForward execute(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {
        response.setContentType("text");
        String name = request.getParameter("name");
        if (name != null) {
            Object[] param = {name};
            String libelle = (String) f.lancerMethode(param, "getLibelleFormation");
            if (libelle != null) {
                response.getWriter().print(libelle);
            }
        } else {
            ArrayList<String> results = (ArrayList<String>) f.lancerMethode(null, "getDistinctLibellesFormation");
            if (results != null) {
                for (String val : results) {
                    response.getWriter().print(val + ";");
                }
            }
        }
        return null;
    }
}
