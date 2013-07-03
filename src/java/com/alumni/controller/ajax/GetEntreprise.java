package com.alumni.controller.ajax;

import com.alumni.controller.SuperAction;
import com.alumni.mapping.Entreprise;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class GetEntreprise extends SuperAction {

    public GetEntreprise() throws InstantiationException, ClassNotFoundException, IllegalAccessException {
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
            Entreprise e = (Entreprise) f.lancerMethode(param, "getEntreprise");
            System.out.println("SEARCH pour " + name + " donne : " + e);
            if (e != null) {
                response.getWriter().print(e.getNomentreprise());
            }
        } else {
            ArrayList<Entreprise> results = (ArrayList<Entreprise>) f.lancerMethode(null, "getEntreprises");
            if (results != null) {
                for (Entreprise val : results) {
                    response.getWriter().print(val.getNomentreprise() + ";");
                }
            }
        }
        return null;
    }
}
