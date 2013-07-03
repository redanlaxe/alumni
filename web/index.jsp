<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Université Paris 1 - Accueil Alumni</title>
        <%@include file="includes/header.jsp" %> 
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <div class="connexion">
            <h1>Alumni - Université Paris 1 Panthéon-Sorbonne</h1>

            <div class="page1">
                <div class="row-fluid">
                    <div class="span12">
                        <html:errors/>
                        <logic:messagesPresent message="true">
                            <html:messages id="message" message="true">
                                <div class="alert alert-success"><bean:write name="message"/></div>
                            </html:messages>
                        </logic:messagesPresent>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span6 br">
                        <html:form styleClass="box" action="/connexion">
                            <h2>J'ai déjà un compte</h2>
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="control-group">
                                        <label class="control-label" for="mail"><label><bean:message key="label.mail" /></label></label>
                                        <div class="controls">
                                            <html:text styleId="mail" styleClass="user" property="mail" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="mdp"><label><bean:message key="label.mdp" /></label></label>
                                        <div class="controls">
                                            <html:password styleId="mdp" styleClass="lock" property="mdp" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span6">
                                    <html:submit styleClass="btn btn-large btn-primary" value="Connexion" />
                                </div>
                                <div class="span6 resteConnecte">
                                    <html:checkbox styleId="resteConnecte" property="resteConnecte" value="true"></html:checkbox>
                                    <label for="resteConnecte"><bean:message key="label.resteConnecte" />
                                </div>
                            </div>
                            <div class="row-fluid forgot">
                                <div class="span12">
                                    <html:link styleClass="btn-oublie" forward="forgotmdp">Mot de passe oublié ?</html:link>
                                    </div>
                                </div>

                        </html:form>
                    </div>
                    <div class="span6">
                        <div class="inscription">
                            <div class="inscription-inside">
                                <h2>Je n'ai pas de compte</h2>
                                <p class="indic">Je suis un étudiant ou une entreprise</p>
                                <div class="sign-btn" title="Inscription"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-fluid page2">
                <div class="row-fluid">
                    <div class="span12">
                        <h2 class="big pagination-centered">Qui suis-je ?</h2>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span6 br">
                        <div class="inscription2">
                            <div class="fleche_gauche"></div>
                            <html:link forward="inscription/etudiant"><h2>Etudiant</h2></html:link>
                                <p class="indic">Etudiant à l'Université Paris 1 Panthéon-Sorbonne ?</p>
                            <html:link styleClass="user-btn" title="Inscription" forward="inscription/etudiant"/>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="inscription2">
                            <div class="fleche_droite"></div>
                            <html:link forward="inscription/entreprise"><h2>Entreprise</h2></html:link>
                                <p class="indic">Je fais partie d'une entreprise souhaitant recruter ?</p>
                            <html:link styleClass="entre-btn" title="Inscription" forward="inscription/entreprise"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="includes/footer.jsp" %> 
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('.sign-btn').unbind('click');
                $('.sign-btn').click(function() {
                    $('.page1').fadeOut(300);
                    $('.page2').show(500).animate({
                        opacity: 1
                    });
                    return false;
                });
            });
        </script>
    </body>
</html>