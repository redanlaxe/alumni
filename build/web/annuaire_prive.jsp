<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annuaire privé</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %>
        <div class="annuaire">
            <h1>Annuaire privé</h1>

            <html:errors/>

            <html:form styleClass="form-inline" action="/annuaireprive">
                <label for="anneedeb"><bean:message key="label.affine"/></label>
                <html:text property="anneedeb" styleId="anneedeb"/>
                <html:submit styleClass="btn btn-primary" value="Affiner"/>
            </html:form>
            <logic:present name="etudiantsp">
                <bean:size id="size" name="etudiantsp"/>
                <logic:equal name="size" value="0">
                    <b>
                        Aucun étudiant trouvé pour cette promotion
                    </b>
                </logic:equal>
                <logic:greaterThan name="size" value="0">
                    <table class="table table-striped table-hover table-bordered">
                        <tr>
                            <th>Voir son profil</th>
                            <th>Prenom</th>
                            <th>Nom
                            <th>Mail</th>
                            <th>Téléphone</th>
                            <th>CV</th>
                        </tr>
                        <logic:iterate id="etudiant" name="etudiantsp">
                            <tr>
                                <td><a href="profil.do?id=<bean:write name="etudiant" property="idetudiant"/>">Profil</a></td>
                                <td><bean:write name="etudiant" property="prenom"/></td>
                                <td><bean:write name="etudiant" property="nom"/></td>
                                <td><a target="_blank" href="mailto:<bean:write name="etudiant" property="mail"/>" onclick="window.open(this.href, '', config = 'height=500, width=800')">Envoyer un mail</a></td>
                                <td><bean:write name="etudiant" property="telephone"/></td>
                                <td><a href="<bean:write name="etudiant" property="cv"/>">CV</a></td>
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
