<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Valider</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %>
        <h1>Valider</h1>

        <html:errors/>


        <logic:present name="nonvalides">
            <bean:size id="size" name="nonvalides"/>
            <logic:equal name="size" value="0">
                <b>
                    Pas d'étudiant à valider
                </b>
            </logic:equal>
            <logic:greaterThan name="size" value="0">
                <h2>Etudiant(es) à valider</h2>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <th>Prénom</th>
                        <th>Nom</th>
                        <th>Email</th>
                        <th>Date de naissance</th>
                        <th>Valider</th>
                        <th>Refuser</th>
                    </tr>
                    <logic:iterate id="etudiant" name="nonvalides">
                        <tr>
                            <td><bean:write name="etudiant" property="prenom"/></td>
                            <td><bean:write name="etudiant" property="nom"/></td>
                            <td><bean:write name="etudiant" property="mail"/></td>
                            <td><bean:write name="etudiant" property="datenaissance"/></td>
                            <bean:define id="identifiant" name="etudiant" property="idetudiant"/>
                            <bean:define id="nom" name="etudiant" property="nom"/>
                            <bean:define id="prenom" name="etudiant" property="prenom"/>
                            <td><html:link styleClass="btn btn-success" href="validation.do?id=${identifiant}&action=valider&type=etudiant" >V</html:link></td>
                            <td><html:link styleClass="btn btn-danger" href="validation.do?id=${identifiant}&action=invalider&type=etudiant" onclick="return(confirm('Confirmez-vous que ${nom} ${prenom} n est pas un étudiant ?'));">X</html:link></td>
                            </tr>
                    </logic:iterate>
                </table>
            </logic:greaterThan>
        </logic:present>


        <logic:present name="cnonvalides">
            <bean:size id="size" name="cnonvalides"/>
            <logic:equal name="size" value="0">
                <b>
                    Pas de contact d'entreprise à valider
                </b>
            </logic:equal>
            <logic:greaterThan name="size" value="0">
                <h2>Contact(s) d'entreprise à valider</h2>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <th>Nom de l'entreprise</th>
                        <th>Poste</th>
                        <th>Personne à contacter</th>
                        <th>Email</th>
                        <th>Téléphone</th>
                        <th>Valider</th>
                        <th>Refuser</th>
                    </tr>
                    <logic:iterate id="contact" name="cnonvalides">
                        <bean:define id="idEnt" name="contact" property="identreprise" type="java.lang.Integer"/>
                        <tr>
                            <td>
                                <logic:present name="entreprises">
                                    <bean:size id="sizeEntre" name="entreprises"/>
                                    <logic:greaterThan name="sizeEntre" value="0">
                                        <logic:iterate id="entreprise" name="entreprises">
                                            <logic:equal name="entreprise" property="identreprise" value="${idEnt}">
                                                <bean:write name="entreprise" property="nomentreprise"/>
                                            </logic:equal>
                                        </logic:iterate>
                                    </logic:greaterThan>
                                </logic:present>
                            </td>
                            <td><bean:write name="contact" property="poste"/></td>
                            <td><bean:write name="contact" property="prenom"/> <bean:write name="contact" property="nom"/></td>
                            <td><bean:write name="contact" property="mail"/></td>
                            <td><bean:write name="contact" property="telephone"/></td>
                            <bean:define id="identifiant" name="contact" property="idcontact"/>
                            <bean:define id="nom" name="contact" property="nom"/>
                            <bean:define id="prenom" name="contact" property="prenom"/>
                            <td><html:link styleClass="btn btn-success" href="validation.do?id=${identifiant}&action=valider&type=contact" >V</html:link></td>
                            <td><html:link styleClass="btn btn-danger" href="validation.do?id=${identifiant}&action=invalider&type=contact" onclick="return(confirm('Confirmez-vous que ${nom} ${prenom} n est pas un contact d entreprise ?'));">X</html:link></td>
                            </tr>
                    </logic:iterate>
                </table>
            </logic:greaterThan>
        </logic:present>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
