package com.miage.alumni

class PersonneController {
    static scaffold = true
    
    def index() { 
        [PersonneList: Personne.list()]
    }
}
