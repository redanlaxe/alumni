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
        <div class="profil">
            <h1>Modifier profil</h1>
            <html:errors/>
            <logic:present name="etudiant">
                <p>Bienvenue <bean:write name="etudiant" property="prenom"/> <bean:write name="etudiant" property="nom"/></p>
                <bean:define id="idEtu" name="etudiant" property="idetudiant" type="java.lang.Integer"/>
            </logic:present>
            <html:link forward="modifProfil">Modifier</html:link>

            <h2> Expériences </h2>
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
                            <th>Salaire</th>
                            <th>Competence</th>
                            <th>Modifier </th>
                            <th>Supprimer </th>
                        </tr>
                        <logic:iterate id="experience" name="experiences">
                            <tr>      
                                <td><bean:write name="experience" property="intituleposte"/></td> 
                                <td><bean:write name="experience" property="typecontrat"/></td>
                                <bean:define id="idExp" name="experience" property="idexperience" type="java.lang.Integer"/>
                                <bean:define id="idEnt" name="experience" property="identreprise" type="java.lang.Integer"/>
                                <logic:present name="salaires">
                                    <bean:size id="sizeSal" name="salaires"/>
                                    <logic:equal name="sizeSal" value="0">
                                        <td></td>
                                    </logic:equal>
                                    <logic:greaterThan name="sizeSal" value="0">
                                        <td class="salaire-wrap">
                                            <div class="row-fluid">
                                                <span class="span6 title">Année</span>
                                                <span class="span6 title">Montant</span>
                                            </div>
                                            <logic:iterate id="salaire" name="salaires">
                                                <logic:equal name="salaire" property="idexperience" value="${idExp}">
                                                    <div class="row-fluid salaire-row">
                                                        <span class="span6 annee"><bean:write name="salaire" property="annee"/></span>
                                                        <span class="span6 valeur"><bean:write name="salaire" property="valeur"/></span>
                                                    </div>
                                                </logic:equal>
                                            </logic:iterate>
                                        </td>
                                    </logic:greaterThan>
                                </logic:present>
                                <td class="column-competence">
                                    <logic:present name="competences">
                                        <bean:size id="sizeComp" name="competences"/>
                                        <logic:equal name="sizeComp" value="0">
                                            
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
                                <td><html:link href="./settings.do?idEtu=${idEtu}&idExp=${idExp}&action=u">Modifier</html:link></td>
                                <td><html:link href="./settings.do?idEtu=${idEtu}&idExp=${idExp}&action=d" onclick="return(confirm('Confirmer la suppression de l'expérience ?'))">Supprimer</html:link></td>
                            </tr>
                        </logic:iterate>
                    </table>
                </logic:greaterThan>
            </logic:present>
            <html:link forward="experience">Ajouter une expérience</html:link>
            <h2>Formations</h2>
            <logic:present name="anneesformation">

                <bean:size id="size" name="anneesformation"/>
                <logic:equal name="size" value="0">
                    <b>Aucune formation</b>
                </logic:equal>
                <logic:greaterThan name="size" value="0">
                    <table class="table table-striped table-hover table-bordered">
                        <tr>
                            <th>Etablissement </th>
                            <th>Formation</th>
                            <th>Année</th>
                            <th>Modifier</th>
                            <th>Supprimer</th>
                        </tr>

                        <logic:iterate id="anneeformation" name="anneesformation">
                            <bean:define id="idFor" name="anneeformation" property="idformation" type="java.lang.Integer"/>
                            <tr>
                                <td> <bean:write name="anneeformation" property="anneeuniversitairedebut"/> -
                                    <bean:write name="anneeformation" property="anneeuniversitairefin"/>  </td>
                                <td><bean:write name="anneeformation" property="ecole"/></td>
                                <td><bean:write name="anneeformation" property="libelle"/></td>
                                <td><html:link href="./settings.do?idEtu=${idEtu}&idFor=${idFor}&action=u">Modifier</html:link></td>
                                <td><html:link href="./settings.do?idEtu=${idEtu}&idFor=${idFor}&action=d" onclick="return(confirm('Confirmez-vous la suppression de la formation ?'))">Supprimer</html:link></td>
                            </logic:iterate>

                        </tr>
                    </table>
                </logic:greaterThan>
            </logic:present>
            <html:link forward="formation">Ajouter une formation</html:link>
        </div>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
