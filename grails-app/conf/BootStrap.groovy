import com.miage.alumni.*

class BootStrap {

    def init = { servletContext ->
        
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError:true)
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError:true)
        
        def user0 = Personne.findByUsername('user0') ?: new Personne(username: 'user0', enabled: true, password:'pass', firstName: 'first', lastName: 'user').save(failOnError:true)
        if(!user0.authorities.contains(userRole))
        {
            PersonneRole.create user0, userRole, true
        }
        
        
        def user1 = Personne.findByUsername('day') ?: new Personne(username: 'day', enabled: true, password:'pass', firstName: 'day', lastName: 'Ka').save(failOnError:true)
        if(!user1.authorities.contains(userRole))
        {
            PersonneRole.create user1, userRole, true
        }
        if(!user1.authorities.contains(adminRole))
        {
            PersonneRole.create user1, adminRole, true
        }
        
        assert Personne.count() == 2
        assert Role.count() == 2
        assert PersonneRole.count() == 2
    }
    
    def destroy = {}
}
