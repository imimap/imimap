# Notes zu Devise und Cancancan

## Devise

Grundsätzlich muss man für alles eingeloggt sein
- in ApplicationController:

    before_action :authenticate_user!

### ActiveAdmin:
authenticate_active_admin_user ist in ApplicationController definiert und in ActiveAdmin config konfiguriert  

Andere Rollen werden über cancancan differnziert.

## CanCanCan

see [https://github.com/CanCanCommunity/cancancan](https://github.com/CanCanCommunity/cancancan)

Rechte sind in ability.rb definiert

in ApplicationController wird sichergestellt, dass ein Fehler geworfen wird wenn cancancan nicht gefragt wurde

check_authorization unless: :devise_or_active_admin_controller?

in ApplicationResourceController für alle Controller & Actions global angeschaltet:

    authorize_resource

- damit wird die Authorization für den jeweiligen
Controller & Action ausgeführt.

### Maps Authorization
Da CanCan nicht über Controller, sondern Resourcen authorisiert,
geschieht dies über Internship.

hier sind 
