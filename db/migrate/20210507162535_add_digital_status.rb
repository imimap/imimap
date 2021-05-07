class AddDigitalStatus < ActiveRecord::Migration[6.1]
  def up
    RegistrationState.create(name: 'digitally available', name_de: 'digital verfuegbar')
    ContractState.create(name: 'digitally available', name_de: 'digital verfuegbar')
  end
  def down
    RegistrationState.delete(name: 'digitally available', name_de: 'digital verfuegbar')
    ContractState.delete(name: 'digitally available', name_de: 'digital verfuegbar')
  end
end
