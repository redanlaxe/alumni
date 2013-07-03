<div class="container-fluid">
    <div class="navbar">
        <div class="navbar-inner">
            <div class="navbar-inside">
                <a class="brand" href=""><img src="img/g/miage_couleur.jpg" alt="MIAGE Sorbonne"></a>
                <ul class="nav">
                    <li><html:link forward="annuairepublic">Annuaire</html:link></li>
                    <logic:present name="etudiant">                        
                        <li><html:link forward="profil">Mon profil</html:link></a></li>                        
                    </logic:present>
                    <logic:present name="admin">
                        <li><html:link forward="validation">Valider</html:link></li>
                        <li><html:link forward="stats">Statistiques</html:link></a></li>
                    </logic:present>
                    <logic:present name="contact">
                        <li><a target="_blank" href="http://www.univ-paris1.fr/diplomes/miage/">MIAGE Sorbonne</a></li>
                    </logic:present>
                    <li><html:link forward="deconnexion">Déconnexion</html:link></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="content-inside">
