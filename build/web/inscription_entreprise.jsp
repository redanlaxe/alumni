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
            <h1>Créer un compte pour accéder à l'annuaire MIAGE Sorbonne</h1>
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
                            <h2>Réseau de qualité</h2>
                            <p>
                                Inscrivez-vous sur l'application et trouvez peut-être votre futur employé grâce à l'annuaire public.
                            </p>
                        </div>
                        <div class="row-fluid">
                            <h2>MIAGE Sorbonne</h2>
                            <p>
                                La Miage Sorbonne est une formation d'excellence en systèmes d'information formant des cadres dans le domaine de l'Informatique des Organisations.
                            </p>
                        </div>
                        <div class="row-fluid">
                            <h2>Stage ou Emploi</h2>
                            <p>
                                Que ce soit pour un stage ou une embauche, n'hésitez pas à vous inscrire pour accéder à la liste des anciens de la MIAGE Sorbonne.
                            </p>
                        </div>
                        <div class="logo-paris-1 row-logo row-fluid pagination-centered">
                            <img src="img/g/logo_univ_paris_1.png" alt="Université Paris 1 - Panthéon Sorbonne" />
                        </div>
                    </div>
                    <div class="span1"></div>
                </div>
                <div class="span7">
                    <html:form styleClass="box" action="/inscription/entreprise">
                        <%@include file="includes/signup_starter.jsp" %> 
                        <div class="control-group">
                            <label class="control-label" for="entreprise"><bean:message key="label.entreprise" /></label>
                            <div class="controls">
                                <html:text styleId="entreprise" property="entreprise" />
                            </div>
                        </div>
                        <div class="control-group adresseEntreprise">
                            <label class="control-label" for="adresseEntreprise"><bean:message key="label.adresse.entreprise" /></label>
                            <div class="controls">
                                <html:text styleId="adresseEntreprise" property="adresseEntreprise" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="poste"><bean:message key="label.poste" /></label>
                            <div class="controls">
                                <html:text styleId="poste" property="poste" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="telephone"><bean:message key="label.telephone" /></label>
                            <div class="controls">
                                <html:text styleId="telephone" property="telephone" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                <html:hidden property="compte" value="entreprise"/>
                                <html:submit value="S'enregistrer" styleClass="btn btn-large btn-primary"/>	
                            </div>
                        </div>
                    </html:form>
                </div>
            </div> 
            <%@include file="includes/footer.jsp" %>
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
            <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
            <script type="text/javascript">
                $(document).ready(function() {
                    $.ajax({
                        type: "POST",
                        url: "./getEntreprise.do",
                        success: function(response) {
                            listEntreprise = response.split(';');
                            $("#entreprise").autocomplete({
                                source: listEntreprise,
                                minLength: 2,
                                close: function(event, ui) {
                                    searchEntreprise();
                                }
                            });
                        }
                    });
                    $('#entreprise').keyup(function() {
                        searchEntreprise();
                    });
                });
                function searchEntreprise() {
                    if ($('#entreprise').val().length > 2) {
                        $.ajax({
                            type: "GET",
                            data: "name=" + $('#entreprise').val(),
                            url: "./getEntreprise.do",
                            success: function(response) {
                                if (response.length > 0) {
                                    $('div.adresseEntreprise').slideUp(800);
                                } else {
                                    $('div.adresseEntreprise').slideDown(800);
                                }
                            }
                        });
                    }
                }
            </script>
    </body>
</html>
