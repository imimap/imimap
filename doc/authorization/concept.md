# Authorization in der IMI-Map

- im Moment über LDAP
- LDAP Modul in devise
- bei erster Anmeldung wird User angelegt mit zufälligem Passwort
  (in ldap_authenticatable.rb)
- später sollte über password reset das passwort zu setzen sein, erstmal nur
  über ldap
- evtl später ldap durch Shibboleth Server ersetzen
   https://datenschutz.htw-berlin.de/verfahren/shibboleth/
- zugangsrechte über positivliste ("whitelisting")  
  in ApplicationController before_action :authenticate_user!
- ActiveAdmin in initializer:   config.authentication_method = :authenticate_active_admin_user!
  über User.role wie in
  https://github.com/plataformatec/devise/wiki/How-To:-Add-an-Admin-Role
  beschrieben
   def authenticate_active_admin_user!
     user = authenticate_user!
     throw(:warden) unless user.admin?
   end

- ausserhalb von ActiveAdmin / User Bereich restriktives Setzen der Rechte

## Student_innen:

### User: eigenes User-Objekt sehen & bearbeiten
- email-Adresse kann nie geändert werden (s0123 /htw adresse muss drin bleiben)
- im moment stehen da präferenzen wie email öffentlich?

### Internship & Student


- Student.enrolment number kann nie geändert werden
- vor Anmeldung des Praktikums kann sowohl eigenes Student & Internship Objekt
angelegt und voll editiert werden
- nach der Anmeldung kann Student Object (nur name, email) geändert werden

Rechte bzgl der Internship verändern sich:

#### Nie veränderbar
student_id - nie veränderbar

#### Nur vor Antrag editierbar
company_address_id -
BASIC_ATTRIBUTES = %i[semester_id start_date end_date].freeze
WORK_DESCRIPTION_ATTRIBUTES = %i[operational_area
                                 orientation_id description title tasks].freeze


#### Nur über ActiveAdmin editierbar
STATE_ATTRIBUTES = %i[internship_state_id contract_state_id registration_state_id
                      report_state_id payment_state_id
                      reading_prof_id certificate_signed_by_internship_officer
                      certificate_signed_by_prof
                      certificate_state_id
                      certificate_to_prof].freeze
SUPERVISOR_ATTRIBUTES = %i[supervisor_email
                            supervisor_name].freeze
NOT_USED_ATTRIBUTES = %i[completed user_id].freeze



#### Nach Abschluss der Internship von Student_in editierbar

payment_state_id

REVIEW_ATTRIBUTES = %i[comment
                       recommend
                       working_hours
                       salary
                       living_costs
                       internship_rating_attributes
                       internship_rating_id
                       email_public].freeze
REPORT_ATTRIBUTES = [:internship_report].freeze
NESTED_ATTRIBUTES = [{ programming_languages: [] }].freeze


Internship

#### Company & CompanyAddress
von Studierenden nicht editierbar, aber neu anlegbar.

(Problem: beim Anlegen einer Internship werden so alle Companies sichtbar)

#### Praktikumsangebote
- index und einzelne sichtbar. werden von Admins gepflegt.

## Login

beim ersten Login wird immer ein User-Objekt mit der email-Adresseangelegt.
Die dazu verwendete email-adresse
kann entweder name@htw-berlin.de sein (für Profs, MA, default rolle :user,
kann nur über ActiveAdmin von Admins geändert werden).
bei Verwendung von s012345@htw-berlin.de wird der User als STudent_in eingeordnet
und entweder dem vorhandenen Student-Objekt über die Matrikelnummer zugeordnet
oder automatisch ein Student-Objekt angelegt. Internship wird über Interface
selbst angelegt.

email ändern im User-Objekt ist nicht vorgesehen.




## Internship - Suche:

Student_innen dürfen nicht alle Internships sehen.
Vielleicht war so das Favourites-Modell gedacht?
Einzelne Markieren und diese dann ansehen?
