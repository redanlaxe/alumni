<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alumni - Mes expériences</title>
        <%@include file="includes/header.jsp" %> 
        <link rel="stylesheet" href="css/jquery-ui-1.10.2.custom.min.css">
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <h1>Mes expériences</h1>
        <div class="experience">
            <html:errors/>

            <html:form action="/experience" styleClass="box">
                <label for="typecontrat"><bean:message key="label.experience.typecontrat" /></label>
                <html:select property="typecontrat" >
                    <html:option value="0">Selectionner type de contrat</html:option>
                    <html:option value="cdd">CDD</html:option>
                    <html:option value="cdi">CDI</html:option>
                    <html:option value="stage">Stage</html:option>
                    <html:option value="freelance">Freelance</html:option>
                    <html:option value="interim">Interim</html:option>
                </html:select>
                <label for="debut"><bean:message key="label.experience.debut" /></label>
                <html:text property="debut" styleClass="datepicker" styleId="debut"/>
                <label for="fin"><bean:message key="label.experience.fin" /></label>
                <html:text property="fin" styleClass="datepicker" styleId="fin"/>
                <label for="intituleposte"><bean:message key="label.experience.intituleposte" /></label>
                <html:text property="intituleposte" />
                <div class="control-group">
                    <label class="control-label" for="nomentreprise"><bean:message key="label.entreprise" /></label>
                    <div class="controls">
                        <html:text styleId="nomentreprise" property="nomentreprise" />
                    </div>
                </div>
                <div class="control-group adresseEntreprise">
                    <label class="control-label" for="adresseEntreprise"><bean:message key="label.adresse.entreprise" /></label>
                    <div class="controls">
                        <html:text styleId="adresseEntreprise" property="adresseEntreprise" />
                    </div>
                </div>
                <h2> Compétences</h2>
				<div id="champsCompetences"></div>
                <html:text property="competence" styleId="competence"/>
				<span id="addCompetence" class="btn">Ajouter</span>
                <html:hidden property="listeComp" styleId="listeComp" />
                <h2> Salaires</h2>
                <span id="addSalaire" class="btn" onclick="addSalaire();">Associer un salaire</span>
                <div id="champsSalaire"></div>
                <html:submit value="Ajouter Expérience" styleClass="btn btn-large btn-primary"/>	
            </html:form>
        </div>
        <%@include file="includes/footer.jsp" %>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
        <script type="text/javascript">
            var counter=0;
            $(document).ready(function() {
				$("#addCompetence").click(function() {
					var val = $('#competence').val();
					var actuel = $('#listeComp').val();
					if (actuel.indexOf(val)	== -1) {
						if (actuel.length > 0) {
							$('#listeComp').val(actuel + ";" + val);
						} else {
							$('#listeComp').val(val);
						}
						$('#competence').val("");
						$("#champsCompetences").append('<span class="competence">'+val+'</span>')
					}	
				});
                $.datepicker.setDefaults($.datepicker.regional[ "fr" ]);
                $(".datepicker").datepicker({
                    showButtonPanel: true,
                    currentText: "Aujourd'hui",
                    closeText: "Fermer",
                    defaultDate: "-1y",
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
                $.ajax({
                    type: "POST",
                    url: "./getCompetence.do",
                    success: function(response) {
                        listCompetence = response.split(';');
                        $("#competence").autocomplete({
                            source: listCompetence,
                            minLength: 1,
                            close: function(event, ui) {
								var val = $('#competence').val();
								var actuel = $('#listeComp').val();
								if (actuel.indexOf(val)	== -1) {
									if (actuel.length > 0) {
										$('#listeComp').val(actuel + ";" + val);
									} else {
										$('#listeComp').val(val);
									}
									$('#competence').val("");
									$("#champsCompetences").append('<span class="competence">'+val+'</span>')
								}
                                searchCompetence();
                            }
                        });
                    }
                });
                $('#competence').keyup(function() {
                    searchCompetence();
                });
            });
            function searchCompetence() {
                $.ajax({
                    type: "GET",
                    data: "name=" + $('#competence').val(),
                    url: "./getCompetence.do"
                });
            }
            
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "./getEntreprise.do",
                    success: function(response) {
                        listEntreprise = response.split(';');
                        $("#nomentreprise").autocomplete({
                            source: listEntreprise,
                            minLength: 2,
                            close: function(event, ui) {
                                searchEntreprise();
                            }
                        });
                    }
                });
                $('#nomentreprise').keyup(function() {
                    searchEntreprise();
                });
            });
            function searchEntreprise() {
                if ($('#nomentreprise').val().length > 2) {
                    $.ajax({
                        type: "GET",
                        data: "name=" + $('#nomentreprise').val(),
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
            
            function addSalaire(){
                var dateDebut =  $("#debut").val();
                if(dateDebut == ""){
                    alert("Veuillez indiquer une date de début !!")
                }
                else{
                    var dateFin =  $("#fin").val();
                    // Variable permettant de savoir jusqu'à quelle année on doit allé dans le select
                    var anneeFin;
                    var donneeDateDebut = dateDebut.split("-");
                    
                    if(dateFin != ""){
                        var donneeDateFin = dateFin.split("-");
                        anneeFin = donneeDateFin[2];
                    }else {
                        var anneeActuelle= new Date(); 
                        anneeFin = anneeActuelle.getFullYear();
                    }
                    
                    var anneeDebut = donneeDateDebut[2];
                    var diff = anneeFin - anneeDebut + 1;
                    var html = "<input type='text' name='salaire["+this.counter+"].valeur' value='Montant' onclick=\"this.value='';\"/> <select name='salaire["+this.counter+"].annee'><option value='0'>Selectionner une année</option>";
                    for(var i=0;i<diff;i++){
                        html += "<option value='"+anneeDebut+"'>"+anneeDebut+"</option>";
                        anneeDebut++;
                    }
                    html += "</select>";
                    $("#champsSalaire").append(html);
                    this.counter++;
                }
            }
           
        </script>
    </body>
</html>
