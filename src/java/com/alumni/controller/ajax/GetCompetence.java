/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.alumni.controller.ajax;

import com.alumni.controller.SuperAction;
import com.alumni.mapping.Competence;
import com.alumni.mapping.Entreprise;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Dimitri
 */
public class GetCompetence extends SuperAction {

    public GetCompetence() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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
            Competence comp = (Competence) f.lancerMethode(param, "getCompetence");
            if (comp != null) {
                response.getWriter().print(comp.getLibelle());
            }
        } else {
            ArrayList<String> results = (ArrayList<String>) f.lancerMethode(null, "getDistinctCompetences");
            if (results != null) {
                for (String val : results) {
                    response.getWriter().print(val + ";");
                }
            }
        }
        return null;
    }
}
