class AddInitialRegistrationStates < ActiveRecord::Migration
	def up
		RegistrationState.create(name: "accepted", name_de: "zugelassen")
		RegistrationState.create(name: "accepted, but courses are missing", name_de: "zugelassen, aber bestandene Kurse fehlen")
		RegistrationState.create(name: "accepted, but contract is missing", name_de: "zugelassen, aber Vertrag fehlt")

	end

	def down
		RegistrationState.delete(name: "accepted", name_de: "zugelassen")
		RegistrationState.delete(name: "accepted, but courses are missing", name_de: "zugelassen, aber bestandene Kurse fehlen")
		RegistrationState.delete(name: "accepted, but contract is missing", name_de: "zugelassen, aber Vertrag fehlt")

	end
end
