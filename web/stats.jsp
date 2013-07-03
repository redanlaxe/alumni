<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Université Paris 1 - Statistique</title>
        <%@include file="includes/header.jsp" %> 
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <div class="statistique">
            <h1>Section Statistique</h1>
            <div class="row-fluid">
                <div class="span12">
                    <html:errors/>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <ul class="nav nav-tabs" id="stats">
                        <li class="active"><a href="#salaire">Salaire</a></li>
                        <li><a href="#competence">Compétences</a></li>
                        <li><a href="#contrat">Type de contrat</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="salaire">
                            <h2>Salaire moyen à l'embauche</h2>
                            <logic:present name="salaireEmbauche">
                                <bean:size id="size" name="contrats"/>
                                <logic:equal name="size" value="0">
                                    <b>Aucune moyenne possible</b>
                                </logic:equal>
                                <logic:greaterThan name="size" value="0">
                                    <bean:write name="salaireEmbauche"/>
                                </logic:greaterThan>
                            </logic:present>

                            <h2>Salaire moyen actuel</h2>
                            <logic:present name="salaireActuel">
                                <bean:size id="size" name="contrats"/>
                                <logic:equal name="size" value="0">
                                    <b>Aucune moyenne possible</b>
                                </logic:equal>
                                <logic:greaterThan name="size" value="0">
                                    <bean:write name="salaireActuel"/>
                                </logic:greaterThan>
                            </logic:present>
                        </div>
                        <div class="tab-pane" id="competence">
                            <div class="row-fluid">
                                <div class="span4">
                                    <h2>Top Compétences</h2>
                                    <logic:present name="competences">
                                        <bean:size id="size" name="competences"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucune(s) compétence(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <table class="table table-striped table-bordered table-condensed">
                                                <tr>
                                                    <th>Compétences:</th>
                                                    <th>Utilisées:</th>
                                                </tr>
                                                <logic:iterate id="competence" name="competences">
                                                    <tr>
                                                        <td><bean:write name="competence" property="key"/></td>
                                                        <td><bean:write name="competence" property="value"/></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                                <div class="span4">
                                    <h2>Top compétences emploi</h2>
                                    <logic:present name="competencesEmploi">
                                        <bean:size id="size" name="competencesEmploi"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucune(s) compétence(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <table class="table table-striped table-bordered table-condensed">
                                                <tr>
                                                    <th>Compétences:</th>
                                                    <th>Utilisées:</th>
                                                </tr>
                                                <logic:iterate id="competenceEmploi" name="competencesEmploi">
                                                    <tr>
                                                        <td><bean:write name="competenceEmploi" property="key"/></td>
                                                        <td><bean:write name="competenceEmploi" property="value"/></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                                <div class="span4">
                                    <h2>Top compétences en stages</h2>
                                    <logic:present name="competencesStage">
                                        <bean:size id="size" name="competencesStage"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucune(s) compétence(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <table class="table table-striped table-bordered table-condensed">
                                                <tr>
                                                    <th>Compétences:</th>
                                                    <th>Utilisées:</th>
                                                </tr>
                                                <logic:iterate id="competenceStage" name="competencesStage">
                                                    <tr>
                                                        <td><bean:write name="competenceStage" property="key"/></td>
                                                        <td><bean:write name="competenceStage" property="value"/></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="contrat">
                            <div class="row-fluid">
                                <div class="span4">
                                    <h2>Types de contrat toute période</h2>
                                    <logic:present name="contrats">
                                        <bean:size id="size" name="contrats"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucun(s) contrat(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <table class="table table-striped table-bordered">
                                                <tr>
                                                    <th>Type de contrat</th>
                                                    <th>Quantité</th>
                                                </tr>
                                                <logic:iterate id="contrat" name="contrats">
                                                    <tr>
                                                        <td><bean:write name="contrat" property="key"/></td>
                                                        <td><bean:write name="contrat" property="value"/></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                                <div class="span4">
                                    <h2>Types de contrat à l'embauche</h2>
                                    <logic:present name="firstContrats">
                                        <bean:size id="size" name="firstContrats"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucun(s) contrat(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <table class="table table-striped table-bordered">
                                                <tr>
                                                    <th>Type de contrat</th>
                                                    <th>Quantité</th>
                                                </tr>
                                                <logic:iterate id="firstContrat" name="firstContrats">
                                                    <tr>
                                                        <td><bean:write name="firstContrat" property="key"/></td>
                                                        <td><bean:write name="firstContrat" property="value"/></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                                <div class="span4">
                                    <h2>Types de contrat actuel</h2>
                                    <logic:present name="lastContrats">
                                        <bean:size id="size" name="lastContrats"/>
                                        <logic:equal name="size" value="0">
                                            <b>
                                                Aucun(s) contrat(s)
                                            </b>
                                        </logic:equal>
                                        <logic:greaterThan name="size" value="0">
                                            <table class="table table-striped table-bordered">
                                                <tr>
                                                    <th>Type de contrat</th>
                                                    <th>Quantité</th>
                                                </tr>
                                                <logic:iterate id="lastContrat" name="lastContrats">
                                                    <tr>
                                                        <td><bean:write name="lastContrat" property="key"/></td>
                                                        <td><bean:write name="lastContrat" property="value"/></td>
                                                    </tr>
                                                </logic:iterate>
                                            </table>
                                        </logic:greaterThan>
                                    </logic:present>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="includes/footer.jsp" %> 
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script>
                $('#stats a').click(function(e) {
                    e.preventDefault();
                    $(this).tab('show');
                })
            </script>
    </body>
</html>