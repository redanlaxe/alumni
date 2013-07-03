<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alumni - Inscription</title>
        <%@include file="includes/header.jsp" %> 
        <link rel="stylesheet" href="css/jquery-ui-1.10.2.custom.min.css">
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <div class="inscription">
            <h1>S'enregistrer en tant qu'Alumnus</h1>
            <div class="row-fluid">
                <div class="span12 errors-container">
                    <html:errors/>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span5">
                    <div class="span1"></div>
                    <div class="span10">
                        <div class="row-fluid">
                            <h2 class="first">Réseau des anciens</h2>
                            <p>
                                Retrouve tes anciens camarades de la MIAGE. Contacte les via téléphone ou par email pour vous retrouver professionnellement ou amicalement.
                            </p>
                        </div>
                        <div class="row-fluid">
                            <h2>Employé ou employeur</h2>
                            <p>
                                Convaincu par la formation ? 
                                <br/>
                                Recrute tes semblables en t'inscrivant tout de suite.
                            </p>
                        </div>
                        <div class="row-fluid">
                            <h2>Visibilité du Profil</h2>
                            <p>
                                Augmente la visibilité de ton profil en t'inscrivant dans notre annuaire également visible pour les entreprises.
                            </p>
                        </div>
                        <div class="logo-paris-1 row-logo row-fluid pagination-centered">
                            <img src="img/g/logo_univ_paris_1.png" alt="Université Paris 1 - Panthéon Sorbonne" />
                        </div>
                    </div>
                    <div class="span1"></div>
                </div>
                <div class="span7">
                    <html:form styleClass="box" action="/inscription/etudiant">
                        <div class="control-group">
                            <label class="control-label" for="prenom"><bean:message key="label.prenom" /></label>
                            <div class="controls">
                                <html:text styleId="prenom" property="prenom" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="nom"><bean:message key="label.nom" /></label>
                            <div class="controls">
                                <html:text styleId="nom" property="nom" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="mail"><bean:message key="label.mail" /></label>
                            <div class="controls">
                                <html:text styleId="mail" property="mail" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="mdp"><bean:message key="label.mdp" /></label>
                            <div class="controls">
                                <html:password styleId="mdp" property="mdp" />
                            </div>
                            <div class="info">
                                <span>Minimum de 6 caractères</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="dateNaissance"><bean:message key="label.dateNaissance" /></label>
                            <div class="controls">
                                <html:text styleId="dateNaissance" styleClass="datepicker" property="dateNaissance" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="adresse"><bean:message key="label.adresse" /></label>
                            <div class="controls">
                                <html:text styleId="adresse" property="adresse" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="telephone"><bean:message key="label.telephone" /></label>
                            <div class="controls">
                                <html:text styleId="telephone" property="telephone" />
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
                                <html:hidden property="compte" value="etudiant"/>
                                <html:submit value="S'enregistrer" styleClass="btn btn-large btn-primary"/>	
                            </div>
                        </div>
                    </div>
                </html:form>
            </div>
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
