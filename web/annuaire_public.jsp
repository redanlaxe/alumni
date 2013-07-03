<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annuaire public</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %>
        <div class="annuaire">
            <h2>Annuaire public</h2>

            <html:errors/>

            <html:form styleClass="form-inline" action="/annuairepublic">
                <html:text property="anneedeb" styleId="anneedeb"/>
                <html:submit styleClass="btn btn-primary" value="Affiner"/>
            </html:form>
            <logic:present name="etudiants">
                <bean:size id="size" name="etudiants"/>
                <logic:equal name="size" value="0">
                    <b>
                        Pas d'étudiant pour cette promotion
                    </b>
                </logic:equal>
                <logic:greaterThan name="size" value="0">
                    <table class="table table-hover">
                        <tr>
                            <th>Voir Profil</th>
                            <th>Prenom</th>
                            <th>Nom</th>                            
                            <th>Téléphone</th>
                            <th>CV</th>
                            <th>Email</th>
                            <th>Recherche Emploi</th>
                        </tr>
                        <logic:iterate id="etudiant" name="etudiants">
                            <tr>
                                <td><a href="profil.do?id=<bean:write name="etudiant" property="idetudiant"/>">Profil</a></td>
                                <td><bean:write name="etudiant" property="prenom"/></td>
                                <td><bean:write name="etudiant" property="nom"/></td>                                
                                <td><bean:write name="etudiant" property="telephone"/></td>
                                <td><a href="<bean:write name="etudiant" property="cv"/>">CV</a></td>
                                <td><a href="mailto:<bean:write name="etudiant" property="mail"/>">Envoyer un mail</a></td>
                                <td><logic:present name="etudiant" property="souhaiteemploi">
                                        <logic:equal name="etudiant" property="souhaiteemploi" value="y">
                                            <span class="label label-success">
                                                Oui
                                            </span>
                                            </logic:equal>                                        
                                        <logic:equal name="etudiant" property="souhaiteemploi" value="n">
                                            <span class="label label-important">
                                                Non
                                            </span>
                                            </logic:equal>
                                    </logic:present>
                                </td>
                            </tr>
                        </logic:iterate>
                    </table>
                </logic:greaterThan>
            </logic:present>
            <logic:present name="nbPage">
                <bean:size id="size" name="nbPage"/>
                <logic:equal name="size" value="0">
                    <b>
                    </b>
                </logic:equal>
                <div class="pagination">
                    <ul>
                        <logic:iterate id="nbPageId" name="nbPage">
                            <li><a href="annuairepublic.do?p=<bean:write name="nbPageId"/>"><bean:write name="nbPageId"/></a></li>
                        </logic:iterate>
                    </ul>
                </div>
            </logic:present>
        </div>
        <%@include file="includes/footer.jsp" %>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script>
            $("#anneedeb").attr("placeholder", "Année d'étude")
        </script>
    </body>
</html>
