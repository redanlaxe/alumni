<%-- 
    Document   : VALIDATION
    Created on : 10 avr. 2013, 23:44:34
    Author     : toutgrego
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %>
        <h1>Validation</h1>

        <html:errors/>


        <logic:present name="nonvalides">
            <bean:size id="size" name="nonvalides"/>
            <logic:equal name="size" value="0">
                <b>
                    Aucun étudiant à valider.
                </b>
            </logic:equal>
            <logic:greaterThan name="size" value="0">
                <h2>Etudiant(s) en attente</h2>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <th>Prenom</th>
                        <th>Nom</th>
                        <th>Adresse e-mail</th>
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
                            <td><html:link styleClass="btn btn-danger" href="validation.do?id=${identifiant}&action=invalider&type=etudiant" onclick="return(confirm('Etes vous sur que ${prenom} ${nom} n est pas un étudiant ?'));">X</html:link></td>
                            </tr>
                    </logic:iterate>
                </table>
            </logic:greaterThan>
        </logic:present>


        <logic:present name="cnonvalides">
            <bean:size id="size" name="cnonvalides"/>
            <logic:equal name="size" value="0">
                <b>
                    Aucun contact d'entreprise à valider.
                </b>
            </logic:equal>
            <logic:greaterThan name="size" value="0">
                <h2>Contact(s) d'entreprise en attente</h2>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <th>Entreprise</th>
                        <th>Poste</th>
                        <th>Prénom & Nom</th>
                        <th>Adresse e-mail</th>
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
                            <td><html:link styleClass="btn btn-danger" href="validation.do?id=${identifiant}&action=invalider&type=contact" onclick="return(confirm('Etes vous sur que ${prenom} ${nom} n est pas un contact d entreprise ?'));">X</html:link></td>
                            </tr>
                    </logic:iterate>
                </table>
            </logic:greaterThan>
        </logic:present>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>