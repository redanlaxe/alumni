<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Accueil</title>
        <%@include file="includes/header.jsp" %> 
    </head>
    <body>
        <%@include file="includes/menu.jsp" %> 
        <div class="connexion">
            <h1>Alumni MIAGE Sorbonne</h1>

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
                    <div class="span4 box">
                        <h2>S'inscrire</h2>
                        <div class="inscription">
                            <html:link forward="inscription/etudiant">                                   
                                <html:submit styleClass="btn btn-large btn-primary box" value="Inscription Etudiant" title="Inscription" />
                            </html:link>
                        </div>
                        <div class="inscription">
                            <html:link forward="inscription/entreprise">
                                <html:submit styleClass="btn btn-large btn-primary box" value="Inscription Entreprise" title="Inscription" />
                            </html:link>
                        </div>
                    </div>
                    <div class="span7">
                        <html:form styleClass="box" action="/connexion">
                            <h2>Se connecter</h2>
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
                                    <html:submit styleClass="box btn btn-large btn-primary" value="Connexion" />
                                </div>
                            </div>
                        </html:form>
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