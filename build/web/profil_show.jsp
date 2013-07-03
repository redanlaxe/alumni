<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Completer son profil</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <logic:present name="etudiant_show">
            <bean:define id="nomEtudiant" name="etudiant_show" property="nom" type="java.lang.String"/>
            <bean:define id="prenomEtudiant" name="etudiant_show" property="prenom" type="java.lang.String"/>
        </logic:present>
        <div class="profil">
            <h2>${prenomEtudiant} ${nomEtudiant}</h2>
            <a target="_blank" href="mailto:<bean:write name="etudiant_show" property="mail"/>" onclick="window.open(this.href, '', config='height=500, width=800')">Envoyer un e-mail</a>
            <html:errors/>
            <h3>Formation</h3>
            <logic:present name="anneesformation">

                <bean:size id="size" name="anneesformation"/>
                <logic:equal name="size" value="0">
                    <b>Aucune expérience renseignée</b>
                </logic:equal>
                <logic:greaterThan name="size" value="0">
                    <table class="table table-hover">
                        <tr>
                            <th>Année de formation</th>
                            <th>Ecole</th>
                            <th>Formation</th>
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
            <h3>Expérience</h3>            
            <!-- On récupère les experiences de l'etudiant -->
            <logic:present name="experiences">
                <bean:size id="size" name="experiences"/>
                <logic:equal name="size" value="0">
                    <b>Aucune expérience renseignée</b>
                </logic:equal>
                <!-- L'étudiant à au moins une experience -->

                <logic:greaterThan name="size" value="0">
                    <table class="table table-hover">
                        <tr>
                            <th>Poste</th>
                            <th>Type de contrat</th>
                            <th>Competence</th>
                            <th>Entreprise</th>
                        </tr>
                        <logic:iterate id="experience" name="experiences">
                            <tr>
                                <!-- Infos de l'experience -->                   
                                <td><span class="label"><bean:write name="experience" property="intituleposte"/></span></td> 
                                <td><span class="label label-warning"><bean:write name="experience" property="typecontrat"/></span></td>
                                <!-- On pose une variable qui nous permet de savoir si l'idExperience correspond aux idexperience se trouvant dans salaire, ... -->
                                <bean:define id="idExp" name="experience" property="idexperience" type="java.lang.Integer"/>
                                <bean:define id="idEnt" name="experience" property="identreprise" type="java.lang.Integer"/>
                                <!-- Infos des compétences associés -->
                                <td class="column-competence">
                                    <logic:present name="competences">
                                        <bean:size id="sizeComp" name="competences"/>
                                        <logic:equal name="sizeComp" value="0">
                                            n/a
                                        </logic:equal>
                                        <logic:greaterThan name="sizeComp" value="0">
                                            <logic:iterate id="competence" name="competences">
                                                <logic:equal name="competence" property="idexperience" value="${idExp}">
                                                    <span class="label label-info"><bean:write name="competence" property="libelle"/></span>
                                                </logic:equal>
                                            </logic:iterate>
                                        </logic:greaterThan>
                                    </td>
                                </logic:present>
                                <!-- Infos des entreprises associés -->
                                <logic:present name="entreprises">
                                    <bean:size id="sizeEnt" name="entreprises"/>
                                    <logic:greaterThan name="sizeEnt" value="0">
                                        <td><span class="label label-success">
                                            <logic:iterate id="entreprise" name="entreprises">
                                                <logic:equal name="entreprise" property="identreprise" value="${idEnt}">
                                                    <bean:write name="entreprise" property="nomentreprise"/>
                                                </logic:equal>
                                            </logic:iterate>
                                            </span></td>
                                    </logic:greaterThan>
                                </logic:present>                                    
                            </tr>
                        </logic:iterate>
                    </table>
                </logic:greaterThan>
            </logic:present>            
        </div>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
