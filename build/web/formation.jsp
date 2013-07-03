<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alumni - Formations</title>
        <%@include file="includes/header.jsp" %> 
        <link rel="stylesheet" href="css/jquery-ui-1.10.2.custom.min.css">
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <h1>Mes Formations</h1>
        <div class="experience">
            <html:errors/>
            <logic:present name="anneeFormation">
                <bean:define id="debut" name="anneeFormation" property="anneeuniversitairedebut"/>
                <bean:define id="ecoleFor" name="anneeFormation" property="ecole"/>
                <bean:define id="fin" name="anneeFormation" property="anneeuniversitairefin"/>
                <bean:define id="libelleFor" name="anneeFormation" property="libelle"/>
            </logic:present>
            <logic:notPresent name="anneeFormation">
                <bean:define id="debut" value=""/>
                <bean:define id="ecoleFor" value=""/>
                <bean:define id="fin" value="" />
                <bean:define id="libelleFor" value=""/>
            </logic:notPresent>
            <html:form action="/formation" styleClass="box">
                <table>
                    <tr>
                        <td>
                            <bean:message key="label.formation.anneedeb" />
                        </td>
                        <td>
                            <html:text property="anneedeb" value="${debut}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <bean:message key="label.formation.anneefin" />
                        </td>
                        <td>
                            <html:text property="anneefin" value="${fin}"/>
                        </td>
                    </tr>
                    <tr><td>
                            <bean:message key="label.formation.ecole" />
                        </td><td>
                            <html:text property="ecole" styleId="ecole" value="${ecoleFor}"/>
                        </td></tr>
                    <tr><td>
                            <bean:message key="label.formation.libelle" />
                        </td><td>
                            <html:text property="libelle" styleId="libelle" value="${libelleFor}"/>
                        </td></tr>
                    <tr><td colspan="2">
                            <logic:present name="anneeFormation">
                                <html:submit value="Modifier formation" styleClass="btn btn-large btn-primary"/>
                            </logic:present>
                            <logic:notPresent name="anneeFormation">
                                <html:submit value="Ajouter formation" styleClass="btn btn-large btn-primary"/>
                            </logic:notPresent>

                        </td>
                    </tr>
                </table>
            </html:form>
        </div>
        <%@include file="includes/footer.jsp" %>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
        <script type="text/javascript">
            $.ajax({
                type: "POST",
                url: "./getEcoleFormation.do",
                success: function(response) {
                    listEcole= response.split(';');
                    $("#ecole").autocomplete({
                        source: listEcole,
                        minLength: 2
                    });
                }
            });
            
            $('#ecole').keyup(function() {
                searchEcole();
            });
            function searchEcole() {
                if ($('#ecole').val().length > 2) {
                    $.ajax({
                        type: "GET",
                        data: "name=" + $('#ecole').val(),
                        url: "./getEcoleFormation.do"
                    });
                }
            }
            
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "./getLibelleFormation.do",
                    success: function(response) {
                        listLibelle = response.split(';');
                        $("#libelle").autocomplete({
                            source: listLibelle,
                            minLength: 2
                        });
                    }
                }); 
                $('#libelle').keyup(function() {
                    searchLibelle();
                });
                function searchLibelle() {
                    if ($('#libelle').val().length > 2) {
                        $.ajax({
                            type: "GET",
                            data: "name=" + $('#libelle').val(),
                            url: "./getLibelleFormation.do"
                        });
                    }
                }
            });
        </script>
    </body>
</html>
