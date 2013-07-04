<div class="container-fluid">
    <div class="navbar">
        <div class="navbar-inner">
            <div class="navbar-inside">
                <a class="brand" href=""><img src="img/g/miage_couleur.jpg" alt="MIAGE Sorbonne"></a>
                <ul class="nav">                    
                    <logic:present name="etudiant">
                        <li><html:link forward="profil">Mon profil</html:link></a></li>
                        <li><html:link forward="annuairepublic">Annuaire</html:link></li>
                        <li><html:link forward="deconnexion">D�connexion</html:link></li>
                    </logic:present>
                    <logic:present name="admin">
                        <li><html:link forward="administration">Administration</html:link></li>
                        <li><html:link forward="annuairepublic">Annuaire</html:link></li>
                        <li><html:link forward="statistiques">Statistiques</html:link></a></li>
                        <li><html:link forward="deconnexion">D�connexion</html:link></li>
                    </logic:present>
                    <logic:present name="contact">
                        <li><html:link forward="annuairepublic">Annuaire</html:link></li>
                        <li><html:link forward="deconnexion">D�connexion</html:link></li>
                        <li><a target="_blank" href="http://www.univ-paris1.fr/diplomes/miage/">MIAGE Sorbonne</a></li>
                    </logic:present>                    
                </ul>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="content-inside">
