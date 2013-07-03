<%-- 
    Document   : Profil
    Created on : 4 avr. 2013, 21:10:20
    Author     : Gregory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modifier profil</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <logic:present name="etudiant_show">
            <bean:define id="nomEtudiant" name="etudiant_show" property="nom" type="java.lang.String"/>
            <bean:define id="prenomEtudiant" name="etudiant_show" property="prenom" type="java.lang.String"/>
        </logic:present>
        <div class="profil">
            <h1>Profil : ${prenomEtudiant} ${nomEtudiant}</h1>
            <a target="_blank" href="mailto:<bean:write name="etudiant_show" property="mail"/>" onclick="window.open(this.href, '', config='height=500, width=800')">Envoyer un mail</a>
            <html:errors/>
            <h2>Expériences </h2>            
            <logic:present name="experiences">
                <bean:size id="size" name="experiences"/>
                <logic:equal name="size" value="0">
                    <b>Aucune expérience</b>
                </logic:equal>

                <logic:greaterThan name="size" value="0">
                    <table class="table table-striped table-bordered">
                        <tr>
                            <th>Entreprise</th>
                            <th>Poste</th>
                            <th>Type de contrat</th>
                            <th>Competence</th>
                        </tr>
                        <logic:iterate id="experience" name="experiences">
                            <tr>                
                                <td><bean:write name="experience" property="intituleposte"/></td> 
                                <td><bean:write name="experience" property="typecontrat"/></td>
                                <bean:define id="idExp" name="experience" property="idexperience" type="java.lang.Integer"/>
                                <bean:define id="idEnt" name="experience" property="identreprise" type="java.lang.Integer"/>
                                <td class="column-competence">
                                    <logic:present name="competences">
                                        <bean:size id="sizeComp" name="competences"/>
                                        <logic:equal name="sizeComp" value="0">
                                            n/a
                                        </logic:equal>
                                        <logic:greaterThan name="sizeComp" value="0">
                                            <logic:iterate id="competence" name="competences">
                                                <logic:equal name="competence" property="idexperience" value="${idExp}">
                                                    <span class="competence"><bean:write name="competence" property="libelle"/></span>
                                                </logic:equal>
                                            </logic:iterate>
                                        </logic:greaterThan>
                                    </td>
                                </logic:present>
                                <logic:present name="entreprises">
                                    <bean:size id="sizeEnt" name="entreprises"/>
                                    <logic:greaterThan name="sizeEnt" value="0">
                                        <td>
                                            <logic:iterate id="entreprise" name="entreprises">
                                                <logic:equal name="entreprise" property="identreprise" value="${idEnt}">
                                                    <bean:write name="entreprise" property="nomentreprise"/>
                                                </logic:equal>
                                            </logic:iterate>
                                        </td>
                                    </logic:greaterThan>
                                </logic:present>                                    
                            </tr>
                        </logic:iterate>
                    </table>
                </logic:greaterThan>
            </logic:present>
            <h2>Formations</h2>
            <logic:present name="anneesformation">

                <bean:size id="size" name="anneesformation"/>
                <logic:equal name="size" value="0">
                    <b>Aucune formation</b>
                </logic:equal>
                <logic:greaterThan name="size" value="0">
                    <table class="table table-striped table-hover table-bordered">
                        <tr>
                            <th>Etablissement</th>
                            <th>Formation</th>
                            <th>Année</th>
                        </tr>

                        <logic:iterate id="anneeformation" name="anneesformation">
                            <tr>
                                <td><bean:write name="anneeformation" property="anneeuniversitairedebut"/> -
                                    <bean:write name="anneeformation" property="anneeuniversitairefin"/> </td>
                                <td><bean:write name="anneeformation" property="ecole"/></td>
                                <td><bean:write name="anneeformation" property="libelle"/></td>
                            </logic:iterate>
                        </tr>
                    </table>
                </logic:greaterThan>
            </logic:present>
        </div>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
