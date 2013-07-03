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
            <h1>INSCRIPTION ENTREPRISE</h1>
            <div class="row-fluid">
                <div class="span12 errors-container">
                    <html:errors/>
                </div>
            </div>
            <div class="row-fluid">                
                <div class="span12">
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
                                <html:submit value="S'inscrire" styleClass="box btn btn-large btn-primary"/>	
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
