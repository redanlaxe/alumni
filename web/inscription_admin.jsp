<%-- 
    Document   : inscription_admin
    Created on : 11 avr. 2013, 17:43:27
    Author     : Gregory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inscription Admin</title>
        <%@include file="includes/header.jsp" %> 
    </head>
    <body>
        <%@include file="includes/menu.jsp" %>
        <h1>Enregistrement d'un admin</h1>
        <h2>
            Liste des administrateurs
        </h2>

        <html:errors/>

        <logic:present name="administrateurs">
            <bean:size id="size" name="administrateurs"/>
            <logic:equal name="size" value="0">
                <b>
                    Tous les étudiants ont été validés
                </b>
            </logic:equal>
            <logic:greaterThan name="size" value="0">
                <table class="table table-striped table-hover">
                    <tr>
                        <th>Nom
                        <th>Prenom</th>
                        <th>Adresse e-mail</th>
                        <th>mdp</th>
                    </tr>
                    <logic:iterate id="administrateur" name="administrateurs">
                        <tr>
                            <td><bean:write name="administrateur" property="nom"/></td>
                            <td><bean:write name="administrateur" property="prenom"/></td>
                            <td><bean:write name="administrateur" property="mail"/></td>
                            <td><bean:write name="administrateur" property="mdp"/></td>
                        </tr>
                    </logic:iterate>
                </table>
            </logic:greaterThan>
        </logic:present>
        <h2>
            Ajouter un administrateur
        </h2>
        <html:form action="/inscriptionadmin" >
        <table>
            <tr>
                <th colspan="2">
                    Inscription
                </th>  
            </tr>
            <tr>
                <td>
                   <bean:message key="label.prenom" /> 
                </td>
                <td>
                    <html:text styleId="prenom" property="prenom" />
                </td>
            </tr>
            
            <tr>
                <td>
                   <bean:message key="label.nom" /> 
                </td>
                <td>
                    <html:text styleId="nom" property="nom" />
                </td>
            </tr>
            <tr>
                <td>
                   <bean:message key="label.mail" /> 
                </td>
                <td>
                    <html:text styleId="mail" property="mail" />
                </td>
            </tr>
            <tr>
                <td>
                   <bean:message key="label.mdp" /> 
                </td>
                <td>
                    <html:text styleId="mdp" property="mdp" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <html:submit value="Ajouter" />
                </td>
            </tr>
        </table>
</html:form>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
