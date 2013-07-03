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
        <link rel="stylesheet" href="css/jquery-ui-1.10.2.custom.min.css">
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <h1>Modifier profil</h1>
        <div class="inscription">
            <html:errors/>
            <logic:present name="etudiant">
                <bean:define id="mailEtu" name="etudiant" property="mail"/>
                <bean:define id="nomEtu" name="etudiant" property="nom"/>
                <bean:define id="prenomEtu" name="etudiant" property="prenom"/>
                <bean:define id="mdpEtu" name="etudiant" property="mdp"/>
                <bean:define id="telephoneEtu" name="etudiant" property="telephone"/>
                <bean:define id="adresseEtu" name="etudiant" property="adresse"/>
                <bean:define id="dateEtu" name="etudiant" property="datenaissance"/>
            </logic:present>

            <div class="span7">
                <html:form styleClass="box" action="modifProfil">
                    <div class="control-group">
                        <label class="control-label" for="prenom"><bean:message key="label.prenom" /></label>
                        <div class="controls">
                            <html:text styleId="prenom" property="prenom" value="${prenomEtu}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="nom"><bean:message key="label.nom" /></label>
                        <div class="controls">
                            <html:text styleId="nom" property="nom" value="${nomEtu}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="mail"><bean:message key="label.mail" /></label>
                        <div class="controls">
                            <html:text styleId="mail" property="mail" value="${mailEtu}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="mdp"><bean:message key="label.mdp" /></label>
                        <div class="controls">
                            <html:password styleId="mdp" property="mdp" />
                        </div>
                        <div class="info">
                            <span>6 caractères minimum</span>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="dateNaissance"><bean:message key="label.dateNaissance" /></label>
                        <div class="controls">
                            <html:text styleId="dateNaissance" styleClass="datepicker" property="dateNaissance" value="${dateEtu}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="adresse"><bean:message key="label.adresse" /></label>
                        <div class="controls">
                            <html:text styleId="adresse" property="adresse" value="${adresseEtu}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="telephone"><bean:message key="label.telephone" /></label>
                        <div class="controls">
                            <html:text styleId="telephone" property="telephone" value="${telephoneEtu}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="cv"><bean:message key="label.cv" /></label>
                        <div class="controls">
                            <html:file styleId="cv" property="cv" />
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls end">
                            <html:checkbox styleId="souhaiteEmploi" property="souhaiteEmploi" value="y">
                                <label class="checkbox"></html:checkbox><bean:message key="label.souhaiteEmploi" /></label>
                            <html:submit value="Modifier" styleClass="btn btn-large btn-primary"/>	
                        </div>
                    </div>
                </html:form>
            </div>
            <div class="clearfix"></div>
        </div>
        <%@include file="includes/footer.jsp" %>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function($) {
                $.datepicker.setDefaults($.datepicker.regional[ "fr" ]);
                $(".datepicker").datepicker({
                    showButtonPanel: true,
                    currentText: "Aujourd'hui",
                    closeText: "Fermer",
                    defaultDate: "-21y",
                    dateFormat: "dd-mm-yy",
                    changeMonth: true,
                    changeYear: true,
                    yearRange: "c-15:c+10",
                    nextText: "Suivant",
                    prevText: "Précédent",
                    dayNames: ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"],
                    dayNamesMin: ["Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa"],
                    monthNames: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"],
                    monthNamesShort: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
                });
            });
        </script>
    </body>
</html>
