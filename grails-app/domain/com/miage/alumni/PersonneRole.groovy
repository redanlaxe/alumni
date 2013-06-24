package com.miage.alumni

import org.apache.commons.lang.builder.HashCodeBuilder

class PersonneRole implements Serializable {

	Personne personne
	Role role

	boolean equals(other) {
		if (!(other instanceof PersonneRole)) {
			return false
		}

		other.personne?.id == personne?.id &&
			other.role?.id == role?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (personne) builder.append(personne.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static PersonneRole get(long personneId, long roleId) {
		find 'from PersonneRole where personne.id=:personneId and role.id=:roleId',
			[personneId: personneId, roleId: roleId]
	}

	static PersonneRole create(Personne personne, Role role, boolean flush = false) {
		new PersonneRole(personne: personne, role: role).save(flush: flush, insert: true)
	}

	static boolean remove(Personne personne, Role role, boolean flush = false) {
		PersonneRole instance = PersonneRole.findByPersonneAndRole(personne, role)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(Personne personne) {
		executeUpdate 'DELETE FROM PersonneRole WHERE personne=:personne', [personne: personne]
	}

	static void removeAll(Role role) {
		executeUpdate 'DELETE FROM PersonneRole WHERE role=:role', [role: role]
	}

	static mapping = {
		id composite: ['role', 'personne']
		version false
	}
}
