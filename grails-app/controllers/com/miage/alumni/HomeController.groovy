package com.miage.alumni

import grails.plugins.springsecurity.Secured

@Secured('[ROLE_USER]')
class HomeController {

    def index() { render 'home' }
    
    @Secured('[ROLE_ADMIN]')
    def adminOnly() { render 'admin' }
}
