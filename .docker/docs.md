# IMI-Map Dokumentation
Die IMI-Map ist eine Webapplikation auf Basis von Ruby on Rails, welche Studenten der Hochschule für Technik und Wirtschaft Berlin
dabei unterstützt, Praktika im Ausland zu finden.

Die Applikation wurde im Rahmen einer Veranstaltung des Studiengangs Internationale Medieninformatik entwickelt.

## TL;DR Setup (Development)
Zum lokalen entwickeln muss folgende Software installiert werden:
- [VirtualBox](https://www.virtualbox.org/)
- [Docker](https://www.docker.com/)
- [Homebrew](http://brew.sh/)

```
# Install Dependencies (for running rails commands)
$ brew update && brew install imagemagick@6 node openssl rbenv ruby-build postgresql

# Install the ruby version required by the application
$ cd /path/to/imimaps
$ rbenv install 2.1.5
$ rbenv global 2.1.5 (optional, if you want to set 2.1.5 as your default Ruby version)
$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
$ source ~/.bashrc
$ gem install bundler thor
$ bundle install

# start the development environment
$ ./docker-tool development start

# Open the application in your browser
$ open http://localhost:8080

# For setting up production and staging hosts:
$ brew install ansible

# A user with password-less sudo has to be present on the hosts
# Copy your ssh public key to the remote host and insert it into /home/your_user_name/.ssh/authorized_keys
# customize the ansible inventory to fit your needs:

[production]
imimaps-production.dev-sector.net ansible_user=your_user_name
[staging]
imimaps-staging.dev-sector.net ansible_user=your_user_name

# Customize bootstrap_host/group_vars/{production.ym,staging.yml} to fit your user name

# bootstrap the host for production and staging
$ ansible-playbook -i inventory -l staging  playbook.yml

```

## Status Quo (vor dem IC)
Der Zustand sowie die Deployment-Infrastuktur der IMI Map vor der Durchführung des Independent Courseworks war wiefolgt:

Die Applikation war zu großen Teilen ungetestet. Laut [SimpleCov](https://github.com/colszowka/simplecov), einer Library zu Analyase
von Ruby-Code, lag die Code Coverage der vorhandenen Tests bei etwa 50 Prozent. Das heißt, dass auf Basis der vorhandenen Tests
unmöglich eine Aussage getroffen werden konnte, ob die aktuelle Codebase nach einem Deployment auf das Produktivsystem fehlerfrei
laufen würde.

Das Deployment der Applikation wurde über [Capistrano](http://capistranorb.com/) durchgeführt. Hierbei ist anzumerken, dass sich Deployments
via Capistrano direkt an das Produktivsystem richteten. Die Konfiguration sah keine Trennung von Staging- oder Production-Environments vor.

Die IMI-Map lief auf einem Server innerhalb der Infrastuktur der HTW, vermutlich einer Linux-VM. Hier kam als Applikationsserver
[Unicorn](https://bogomips.org/unicorn/) hinter einem Nginx Reverse-Proxy (siehe `curl http://imi-map.f4.htw-berlin.de/ -I`) zum Einsatz.

## Anforderungen
Die IMI-Map in ihrem aktuellen Zustand war nur äußerst schwierig wartbar. Aus diesem Grunde wurde die Entscheidung getroffen, die
Infrastuktur der Applikation zu ändern.

Dabei ergaben sich folgende Anforderungen:

**Separate Environments**

Um Fehler beim Deployment auf das Produktivsystem vorzubeugen, soll eine Trennung von Development-, Staging-
sowie Produktivsystem vorgenommen werden.
In der Datenbank der IMI Map werden personenbezogene Daten vorgehalten.  Daher sollen Developer keinen direkten Zugriff
auf das Produktivsystem haben.

**Continuous Integration**

Die Applikation soll auf eine solide Basis von Tests gestellt werden, wobei möglichst hohe prozentuale Code-Coverage
erreicht werden sollte. Die Tests sollen automatisch in einem Continuous Integration Service laufen. Hierzu soll
[Travis CI](https://travis-ci.org/) genutzt werden.

**Continuous Delivery**

Für den Fall dass Builds der Continuous Integration erfolgreich sind, soll die Applikation automatisch ausgerollt werden.
Dabei soll jeder Build der Staging-Umgebung auf das Staging-System ausgerollt werden. Deployments auf das Produktivsystem
sollen durch [Tags](https://help.github.com/articles/working-with-tags/) auf GitHub getriggert werden.
Legt ein Developer einen neuen Tag bzw. ein neues Release an, stößt diese einen Travis-Build an. Ist dieser erfolgreich, wird
die Applikation automatisch auf das Produktivsystem deployed.

## Testing
Im Rahmen des ersten Schrittes des Independent Coursework wurde die IMI-Map mit Tests auf Basis von [RSpec](http://rspec.info/) versehen.
Dieser Abschnitt dokumentiert die Tests.
### Installation
Bevor mit der Entwicklung des Test-Frameworks begonnen werden konnte, war es notwendig, die Applikation zum laufen zu bekommen. Hierzu mussten
deren externe Softwareabhängigkeiten installiert werden. Diese können unter macOS Sierra bei Nutzung von Homebrew wiefolgt installiert werden:
```
  $ brew install imagemagick@6 postgresql nodejs sqlite
```
Danach können die Gem-Abhängigkeiten der Rails-App mit `bundle install` installiert werden.
Es ist anzumerken, dass die Gems `factory_girl_rails` sowie  `rspec_rails` auf die jeweils aktuellste Version geupdated worden sind.

#### Probleme
Unter macOS Sierra können bei der Installation der Gem-Abhängigkeiten Probleme auftreten. Die im Rahmen des IC aufgetretenen Probleme sind im Folgenden dokumentiert:

**Eventmachine**

Bei der Installation des Eventmachine Gem kann folgender Fehler auftreten:
```
./project.h:107:10: fatal error: 'openssl/ssl.h' file not found #include <openssl/ssl.h>
```
Dieser Fehler kann durch die Installation von OpenSSL und spezielle Konfiguration des Eventmachine-Gem behoben werden:
```
  $ brew install openssl
  $ cd /path/to/imimaps && bundle config build.eventmachine \
       --with-cppflags=-I/usr/local/opt/openssl/include
  $ bundle install
```

### Factories
Automatisierte Tests sind häufig abhängig von Daten in einer Datenbank. Um diese effizient zu generieren, bietet sich die Nutzung von Factories an.
Das Gem `factory_girl` bietet eine einfache DSL zum erstellen solcher Factories. Im Rahmen des IC wurden Factories für alle in der Applikation vorhandenen Models sowie deren Relationen erstellt.
Diese sind im Verzeichnis `spec/factories` zu finden.

#### Probleme
Beim Erstellen der Factories für die Models `User` und `Student` kam es zu Problemen, deren Ursache und Lösung hier dokumentiert werden soll:

Die oben genannten Models sind über eine 1:1 Relation miteinander verbunden, wobei das User-Model den Verweis auf den Fremdschlüssel des Student-Model (`student_id`) beinhaltet.
Schreibt man nun Factories für die beiden Models wie im folgenden Code-Snippet zu sehen, kommt es beim Ausführen der Tests zu einer Endlosschleife:
```
# User Factory
FactoryGirl.define do
  factory :user do
    ...
    student
  end
end

# Student Factory
FactoryGirl.define do
  factory :student do
    ...
    user
  end
end
```

Dies kann dadurch gelöst werden, dass man das Entstehen der Endlosschleife verhindert, indem man im `after(:build)`-Callback in einer der obigen Factories
das in Beziehung stehende Objekt manuell setzt:
```
FactoryGirl.define do
  factory :user do
    ...
    after(:build) do |user|
      user.student = FactoryGirl.create(:student, user: user)
    end
  end
end
```

Merkwürdigerweise traten hierbei weitere Fehler auf. FactoryGirl meldete, dass die User-Factory nicht validiert werden konnte. Das wiederum
war darauf zurückzuführen, dass im [User-Model](https://github.com/imimaps/imimaps/blob/6c808f0914d1158f8ce2214766072c8928a218e5/app/models/user.rb#L8) eine Validierung
des Attributs `student_id` durchgeführt wurde. \
Dies hat zur Folge, dass sich Instanzen des User-Model nicht validieren lassen, wenn besagtes Attribut nicht vorhanden ist.
Da IDs im Lifecycle von ActiveRecord-Objekten aber erst nach dem Speichern erzeugt werden, ergibt sich hier ein Henne-Ei-Problem.

Die Lösung des Problems war es, die Validierung im User-Model nicht auf `student_id` sondern die Relation selbst durchzuführen.

#### Model
Aktuell bestehen für alle relevanten Models der Applikation Unit-Tests in `/spec/models/`. Mit relevant sind hierbei
solche Models gemeint, die Validations auf einem oder mehreren Attributen durchführen. Es wurde davon abgesehen Models wie
beispielsweise `ReportState` mit Tests zu versehen, da es nicht sonderlich sinnvoll ist zu testen, ob Getter- und Setter- Methoden
funktionieren.

Für alle relevanten Models ist für jede im Model deklarierte Validation mindestens ein Test-Case in der Test-Suite vorhanden.
Für in den Models vorhandene Methoden wurden ebenfalls Tests implementiert.

#### Controller
Tests für Controller-Methoden sind im Verzeichnis `spec/controllers` zu finden. Es sind  [funktionale Tests](http://guides.rubyonrails.org/testing.html#functional-tests-for-your-controllers)
für die Methoden der Controller implementiert worden, bis der Coverage-Report eine ausreichende Testabdeckung anzeigte.

Es ist hierbei anzumerken, dass die in der Codebase vorhandenen Tests nicht nur die Routes und beispielsweise das korrekte Verhalten
von `#create`- und `#update`-Methoden prüfen.
Zusätzlich hierzu ist in der Testklasse jedes einzelnen Controllers mit [`render_views`](https://www.relishapp.com/rspec/rspec-rails/v/2-1/docs/controller-specs/render-views)
angegeben, dass während eines Testlaufs die zur jeweiligen Route gehörigen View-Templates mitgerendert werden sollen.
Dies hat den Vorteil, dass durch die Controller-Tests auch syntaktische Fehler in den View-Templates gefunden werden können.

#### Mailer
Für die Methoden der beiden in der Applikation genutzten Mailerklassen sind Tests in `spec/mailers` zu finden. Diese Tests
können in ihrem aktuellen Zustand allerdings nicht aussagen, ob die Applikation wirklich eine Email versenden wird, sondern
legen Fokus auf korrekte Zuweisung des Subjects der Mail sowie der dem Mail-Template zugeordneten Instanzvariablen.

#### Coverage-Report
Zur Erstellung von Metriken zur Bewertung der aktuellen Testabdeckung der Applikation, wurde das Ruby Gem `SimpleCov` eingesetzt.
Dieses integriert sich problemlos in Railsapplikationen.

Zum Zeitpunkt des Erstellens dieser Dokumentation hat die IMI-Map laut `SimpleCov` eine Test-Coverage
von rund **100%** bei durchschnittlich 5.08 hits per line.

TODO: bild

## Deployment
In den folgenden Abschnitten sollen die für das Deployment der Applikation genutzten Werkzeuge sowie
das Tooling um diese vorgestellt werden.

## Infrastruktur
- docker-engine
- docker-compose
- nginx als reverse proxy
- managed via ansible

## Docker
Docker ist eine quelloffenes Projekt, welches es ermöglicht, beliebige Applikationen in sogenannten Containern zu deployen.
Hierzu nutzt Docker Virtualisierungs-Features auf Betriebssystemebene, sowie Ressourcenisolationsfeatures des Linux-Kernels.

Durch die Nutzung dieser Features fällt der Overhead, welcher beim Starten einer virtuellen Maschine anfällt, weg, da kein
weiteres Betriebssystem gestarten werden muss, sondern die Container über Dockers Bibliotheken den Kernel des Hostsystems selbst nutzen.
Container sind dabei völlig unabhängig und voneinander und laufen in ihrem eigenen isolierten Kontext.

Einer der größten Vorteile von Docker-basierten Deployments ist, dass sämtliche Softwareabhängigkeiten, die eine Applikation hat, zusammen mit der Applikation
selbst in ein Image gepackt werden können. Hierdurch können die unterschiedlichen (möglicherweise konkurrierenden) Abhängigkeiten unterschiedlicher
Applikationen, die auf demselben Hostsystem laufen, problemlos erfüllt werden, da die Applikationen selbst getrennt voneinander in ihrem eigenen Kontext, dem Container,
laufen.

### Image
Docker-Images werden in sogenannten Dockerfiles beschrieben. Die Images der IMI-Map bauen auf dem [offiziellen
Ruby-Image](https://hub.docker.com/_/ruby/) auf, welches Alpine Linux als Basis nutzt. Es wurde die Distribution Alpine genutzt, da diese
kleiner ist als andere Distributionen und damit die Images ebenfalls relativ klein ausfallen.

Das folgende Listing zeigt die aktuelle kommentierte Dockerfile der Development-Umgebung der IMI-Map:

```
# Nutzung von ruby 2.1 auf Basis von Alpine Linux als Basis-Image
FROM ruby:2.1-alpine

# Setzen von Umgebungsvariablen für die Rails-Applikation
ENV APP_HOME /usr/src/app
ENV RAILS_ENV development
ENV RACK_ENV development

# Öffnen des Ports 80, auf welchem die Applikation im Container läuft
EXPOSE 80

# wechseln in das Verzeichnis /usr/src/app
WORKDIR $APP_HOME

# Kopieren von Gemfile, Gemfile.lock und eines Shellscripts, welches die
# Database Migrations ausführt, ins Applikationsverzeichnis
COPY Gemfile* $APP_HOME/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Installation der Applikationsabhängigkeiten
RUN set -ex \
  && apk add --no-cache libpq imagemagick nodejs bash

# Installation der Gems sowie deren Build-Abhängigkeiten
# Um das Image klein zu halten, werden diese nach der Installation der Gems
# wieder entfernt.
RUN set -ex \
  && apk add --no-cache --virtual .builddeps linux-headers libpq build-base postgresql-dev imagemagick-dev \
  && bundle install \
  && apk del .builddeps

# Ausführen der Migrations
ENTRYPOINT ["/docker-entrypoint.sh"]

# Starten der Applikation
CMD ["bundle", "exec", "unicorn", "--port", "80"]
```

### Docker Compose
Viele Applikationen sind abhängig von anderen Services. Insbesondere Webapplikationen benötigen meist die Anbindung an eine Datenbank als Persistenzschicht.
Möchte man nun eine solche Anwendung in einem Docker-Kontext betreiben, werden mehrere Container benötigt, welche miteinander kommunizieren können.

Hier kommt Docker Compose als Werkzeug zum einfachen Verwalten von Multi-Container-Applikationen ins Spiel. Compose definiert eine einfache YAML-basiertes
Konfigurationssprache, mit welcher Multi-Container-Applikationen beschrieben werden können.

Das folgende Listing zeigt die aktuelle kommentierte Docker-Compose-Konfiguration der Development-Umgebung der IMI-Map:

```
version: '2'
services
  # Definition des Datenbankservices: Postgresql in Version 9.6.2 auf Basis von
  # Alpine Linux
  postgresql:
    image: postgres:9.6.2-alpine
    container_name: postresql-development
    # Setzen der notwendigen Umgebungsvariablen für den Postgresql-Prozess
    environment:
      - APPLICATION=imimaps
      - POSTGRES_PASSWORD=imimaps
      - POSTGRES_USER=imimaps
      - POSTGRES_DB=imimaps
    # Öffnen des Postgresql-Ports
    ports:
      - 5432:5432

  # Definition des Applikationsservices. "build ." besagt hierbei, dass das Image
  # mittels der im aktuellen Verzeichnis liegenden Dockerfile erstellt werden soll.
  imimaps:
    build: .
    image: imimaps:development
    container_name: imimaps-development
    environment:
      - APPLICATION=imimaps
      - POSTGRES_PASSWORD=imimaps
      - POSTGRES_USER=imimaps
      - POSTGRES_DB=imimaps
    depends_on:
      - postgresql
    # Mounten des Quelltextes der Applikation nach /usr/src/app
    #innerhalb des Containers
    volumes:
      - .:/usr/src/app
    # Verbinden des Applikationscontainers mit dem Datenbankcontainer.
    # Durch diese Deklaration ist der Datenbankcontainer für die Applikation
    # unter dem Hostname "postgresql" erreichbar.
    links:
      - postgresql

    # Binden des Ports 80 innerhalb des Containers an Port 8080 des Hostsystems
    # Hierdurch wird die Applikation im Browser via http://host:8080 erreichbar.
    ports:
      - 8080:80
```

### Environments
Das Docker-Tooling um die Rails-Applikation definiert aktuell vier unterschiedliche Umgebungen:
- Development
- Staging
- Production
- Test

Wie der Name vermuten lässt, sollte die Umgebung `development` zum lokalen Entwickeln an der Applikation gestartet sein.
Alle anderen Umgebungen sind relevant für Continuous Integration und Continuuous Delivery.

Der Hauptunterschied zwischen der Entwicklungsumgebung und den anderen drei Umgebungen ist, dass bei dieser der Quelltext der Applikation nicht
in das Image kopiert wird, sondern als Volume in den Container eingehängt wird. Dies hat zum Vorteil, dass Änderungen am Code direkt im Browser ersichtlich werden
und nicht extra ein neues Image hierzu erstellt werden muss.

Die Production- und Staging-Environments packen den Code Der IMI-Map direkt in das Image. Zusätzlich hierzu werden die Rails-Assets präkompiliert und Volumes für die
Datenbank sowie die Uploads der Rails-App definiert.

### Tooling
Für die einfache lokale Interaktion mit der Docker-Umgebung der IMI-Map wurde ein Kommandozeilen-Tool entwickelt, welches im Root der Rails-Applikation zu finden ist: `docker-tool`.
Das folgende Listing zeigt die aktuell von `docker-tool` unterstützten Befehle für die Development-Umgebung:

```
./docker-tool development --help
Commands:
  docker-tool development build           # builds the specified environment
  docker-tool development enter           # enters a bash shell in the specified
                                          # environment
  docker-tool development help [COMMAND]  # Describe subcommands
  docker-tool development start           # starts the specified environment
  docker-tool development stop            # stops the specified environment
  docker-tool development test            # runs the test suite
```

Zum starten der Entwicklungsumgebung reicht der Aufruf von `./docker-tool development start` aus.

## CI/CD Pipeline
Entstehend aus den Anforderungen an das Projekt, wurde eine Kette von Tools für das automatisierte Testen sowie für das automatische
Deployment der Applikation erstellt.
Die Bestandteile dieser Pipeline sollen im Folgenden erläutert werden.

### GitHub und Git Workflow
Der Quelltext der IMI-Map liegt in einem Git-Repository, welches auf GitHub gehostet ist. Das Reposiory ist auf GitHub so eingerichtet,
dass es nicht möglich ist, direkt Code in den Branch `master` einzufügen.

Neuer Code oder Änderungen an bestehendem Code müssen in Feature-Branches entwickelt werden. Sollen Änderungen aus einem Feature-Branch
in den `master`-Branch eingefügt werden, ist es hierzu notwendig, einen Pull Request zu erstellen.
Pull Requests aus Feature Branches können nur dann in den `master`-Branch eingefügt werden, sobald die automatisierten Tests auf dem Code im
Pull Request selbst erfolgreich durchgeführt worden sind.

Dies hat den Hintergrund, dass der `master`-Branch stets stabil sein soll.

### Travis
In der CI/CD Pipeline der IMI-Map kommt Travis CI zum Einsatz und wird für folgende Tasks genutzt:
- automatisches Testen
- Erstellen von Docker-Images
- Deployment der Applikation auf die Staging- und Produktivsysteme

#### Security
Da das Git-Repository der Applikation offen für jeden einsehbar ist, ist es notwendig, sämtliche Passwörter und Keys, die für das automatische
Deployment notwendig sind, zu verschlüsseln.
Hierzu wurde die von Travis gelieferte Verschlüsselung für einfache Zeichenketten sowie die für Dateien verwendet.

Aktuell befinden sich die folgenden Credentials in verschlüsselter Form im Repository:
- Zugang zu [Docker Hub](https://hub.docker.com/) in `.travis.yml` in den Umgebungsvariablen `DOCKER_USERNAME` und `DOCKER_PASSWORD`
- SSH Key-Paare für das automatische Deployment in `ssh_keys.tar.enc`

Es befinden sich keine Credentials der CI/CD-Pipeline in unverschlüsselter Form im Code.

Zum Verschlüsseln einzelner Umgebunsvariablen wurden Befehle der folgenden Form verwendet:
```
travis encrypt -r "imimaps/imimaps" DOCKER_PASSWORD="secret_docker_password"
```
Die Ausgabe dieses Befehls wurde danach `.travis.yml` in die Umgebungsvariablen eingefügt.

Die Verschlüsselung ganzer Dateien (in diesem Fall ein TAR-Archiv, welches die SSH Deployment-Keys beinhaltet) wurde wiefolgt durchgeführt:
```
travis encrypt-file -r "imimaps/imimaps" ssh_keys.tar
```
Weitere Information zu Verschlüsselung von Daten mit Travis in der Dokumentation zu finden:
- [Verschlüsselung für Dateien](https://docs.travis-ci.com/user/encrypting-files/)
- [Verschlüsselung für Umgebungsvariablen](https://docs.travis-ci.com/user/encryption-keys/)

#### Travis Builds und Deployments
Für die von Travis durchgeführten Builds wuerde Tooling in Ruby geschrieben. Die Tools sind im Ordner `ci-cd` zu finden.
Der Ablauf der Builds ist wiefolgt:
1. Entschlüsseln der SSH Deployment-Keys für Staging und Production
2. Korrigieren der Berechtigungen der Keys auf `0600`
3. Starten der Docker-Umgebung `test` mittels `docker-tool`. Die Tests werden hierbei innerhalb der Docker-Umgebung durchgeführt.

Die drei oben beschriebenen Schritte werden von Travis bei jeder Interaktion mit dem Git-Reposiory durchgeführt. Die nachfolgenden Schritte
werden nur ausgeführt, falls die Umgebung des Travis-Builds entweder ein [Tagged Release](https://help.github.com/articles/working-with-tags/) oder ein Commit in den
Master-Branch ist. Zusätzlich hierzu müssen die Tests in Schritt 3 erfolreich gewesen sein.

4. Erstellen eines Docker-Images für die neue Version der Applikation (`docker-build.rb`)
5. Pushen des Images in ein Repository auf [Docker Hub](https://hub.docker.com/u/imimaps/dashboard/) (`docker-push.rb`)
6. Deployment des neuen Images (`docker-deploy.rb`)

Sollte Travis erkennen, dass es sich bei dem aktuellen Commit um einen Tag handelt, wird der Deployment-Schritt auf dem Produktivsystem ausgeführt, andernfalls auf dem
Staging-System.


## Improvements
- viele Dinge koennen an der applikation verbessert werden
- diese dinge sollen hier aufgefuehrt werden.

- Rails upgrade
  - spring application loader
  - tests brauchen ewig: der komplette rails stack muss jedes mal geladen werden
  - spring haelt die app im speicher vor.
  - strong parameters in rails 4. siehe unten
  - Migration guides:
  - http://guides.rubyonrails.org/upgrading_ruby_on_rails.html
  - durch die Testcoverage sollte das "relativ" einfach gehen

### Remove Hardcoding
Beispiele:
LDAP Host
- https://github.com/imimaps/imimaps/blob/master/app/controllers/user_verifications_controller.rb#L11
Translations:
- https://github.com/imimaps/imimaps/blob/master/app/controllers/user_verifications_controller.rb#L16
Downloads:
https://github.com/imimaps/imimaps/blob/master/app/views/download/index.html.erb#L12-L15
https://github.com/imimaps/imimaps/blob/master/app/views/general/index.html.erb

### Single table inheritance
- xxx_state models
- attributes: name, name_de
- has_many: internships
- certificate_state, contract_state, internship_state, payment_state, registration_state, report_state
- Single Table. Validations auf base model.
- Alle anderen Models erben
- Reduziert komplexitaet. sollte nur genutzt werden, wenn die models so einfach bleiben, wie sie aktuell sind.

### Proper naming
- https://github.com/imimaps/imimaps/blob/master/db/seeds.rb#L149-L161
- versteht kein mensch

### reduce complexity of methods
- einige methoden sind unverstaendlich.
- macht testing schwierig
- macht maintainability weg
- https://github.com/imimaps/imimaps/blob/master/app/controllers/quicksearches_controller.rb#L3

### ElasticSearch als Search-Backend
- elasticsearch + example
- um die komplexitaet wie in  quicksearches_controller zu vermeiden
- https://github.com/elastic/elasticsearch-rails
- passt sich gut in active model ein
- queries verstaendlicher

### Routes
- Viele routes ungenutzt.
- Viele Controller als RESTful resource deklariert, obwohl nur eine methode genutzt wird
- https://github.com/imimaps/imimaps/blob/master/config/routes.rb

### gmaps4rails
- faq_controller
- general_controller
- es besteht kein grund, diese Controller als restful routes zu deklarieren
- entweder limit nutzen oder named routes auf die jeweilige methode

### Rubocop
- enforce code style
- linting
- http://rubocop.readthedocs.io/en/latest/cops/
- performance

### Unused code, Unused Files, Unused Gems
- remove unused code + unused methods
- remove unused file
- remove unused gems

### strong parameters
- all user input is evil
- Loesung: explizites whitelisting von parametern beim interagieren imt ActiveModel Mass assignments
- https://github.com/rails/strong_parameters
- http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
- Referenzen:
  - https://xkcd.com/327/
  - http://www.codemag.com/article/0705061


### Erweiterung der Test-Suite
- Cucumber (https://cucumber.io/)
- Capybara (https://github.com/teamcapybara/capybara)
- Vorzugsweise mit Poltergeist / Capybara-webkit aus performance-gruenden und integration mit CI
- https://en.wikipedia.org/wiki/Cucumbersoftware

### Validations in models
Viele models testen nur auf presence von attributes
es ist aktuell ohne probleme moeglich sich mit invaliden email-adressen anzumelden, Vorname und Nachname sind nicht validiert. etc.

### Database Seeds mit `factory_girl`
- Seeds mit FactoryGirl
- Bietet sich an, weli die Factories sowieso schon bestehen.
- schneller
- uebersichtlicher

## Lessons learned
- Problems
  - FactoryGirl => 1:1 relationship
  - ImageMagick
  - JSON Gem
  - Travis secrets

## References
- Docker
- Thor
- Docker-Machine
- Docker-Compose
- Travis
  - encryption
  - deployment
  - services
- Markdown to pdf
