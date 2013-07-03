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
public class GetEcoleFormation extends SuperAction {

    public GetEcoleFormation() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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
            String ecole = (String) f.lancerMethode(param, "getEcoleFormation");
            System.out.println("SEARCH pour " + name + " donne : " + ecole);
            if (ecole != null) {
                response.getWriter().print(ecole);
            }
        } else {
            ArrayList<String> results = (ArrayList<String>) f.lancerMethode(null, "getDistinctEcoleFormation");
            if (results != null) {
                for (String val : results) {
                    response.getWriter().print(val + ";");
                }
            }
        }
        return null;
    }
}
