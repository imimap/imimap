# IMI-Map Dokumentation
Die IMI-Map ist eine Webapplikation auf Basis von Ruby on Rails, welche Studenten der Hochschule für Technik und Wirtschaft Berlin
dabei unterstützt, Praktika im Ausland zu finden.

Die Applikation wurde im Rahmen einer Veranstaltung des Studiengangs Internationale Medieninformatik entwickelt.

# Local Setup on Development Machine

Für das lokale Setup gibt es drei Möglichkeiten, rails auszuführen:
- mit [Docker](#setup-mit-docker)
- mit Docker in einer virtuellen Maschine über Vagrant [Vagrant](#setup-mit-vagrant)
- [lokal mit SQLite](#lokales-setup)

## Setup mit Vagrant
IMI-Maps läuft in Docker in einer VM über Vagrant.
Vorteil: wie Docker, lokal wenig Installation notwendig. Empfehlenswert für Windows.
Nachteil: 1 Tool mehr

Zum lokalen entwickeln muss folgende Software installiert werden:
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

```
  cd /path/to/imimaps
  vagrant up
  vagrant ssh

  # innerhalb der VM
  cd /vagrant
  ./docker-tool development start
```

Die Applikation ist dann via [http://192.168.33.10](http://192.168.33.10) erreichbar. Die Migrations sowie Seeds der Datenbank
sind bereits ausgeführt.

## Setup mit Docker
IMI-Maps läuft in Docker.
Vorteil: Konfiguration wie auf Staging/Production Maschinen.
Nachteil: Mehr Komplexität, gerade für Rails-Neulinge noch unübersichtlicher.

Hier beschrieben für MacOS (Package Manager Homebrew), für andere OS z.B.
Linux sind die dependencies mit anderem Package Manger zu installieren.

Zum lokalen entwickeln muss folgende Software installiert werden:
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

```

## Lokales Setup

Ohne Docker, mit SQLite
SQLite is now the default used both in Gemfile as well as config/database.yml

Run tests:

    rake db:migrate RAILS_ENV=test


# Development Process and Deployment Pipeline

## Committing Changes to the Mainline

## CI Builds


## Automated Deployment to Staging

If the travis build was succesfull, an automated deployment is triggered.

This is governed by the method is_release in ci-cd/helpers.rb and only happens
if the DEPLOYMENT_PIPELINE environment variable is set in travis. You can
do this with the travis cli, eg.

    travis env set DEPLOYMENT_PIPELINE dev-sector
    travis env set DEPLOYMENT_PIPELINE heroku

(added by BK to enable forks on github without deployment pipeline and also
  successfull checks for pull-requests from these repositories)

## Production Deployments

Deployments auf das Produktivsystem
werden durch [Tags](https://help.github.com/articles/working-with-tags/) auf GitHub getriggert.
Legt ein_e Entwickler_in einen neuen Tag bzw. ein neues Release an, stößt diese einen Travis-Build an. Ist dieser erfolgreich, wird die Applikation automatisch auf das Produktivsystem deployed.

# Development Workflow

- create a feature branch
- edit files in app
- run and test the app in docker container
- see ./docker-tool development --help

    ./docker-tool development build (builds docker image, only needs to be redone after changes to Gemfile)
    ./docker-tool development start
    ./docker-tool development test

- changes should always be tested locally before committing/pushing.
- push changes to github
- if desirable (and checks are green), create pull request and merge / rebase and merge if possible.
- pull master branch from github and repeat

### oops, forgot to branch

If you accidentially work on the master branch, you'll get an error when
trying to push your changes:
```
remote: Resolving deltas: 100% (6/6), completed with 6 local objects.
remote: error: GH006: Protected branch update failed for refs/heads/master.
remote: error: Required status check "continuous-integration/travis-ci" is expected.
```

just create a new branch and push:

    git checkout -b typos
    git push origin typos

## cleaning your docker environment

Alle Container entfernen: ```docker ps -aq | xargs docker rm -f```
Alle Images entfernen: ```docker images -qa | grep imi | xargs docker rmi -f```


# Setup der Deployment Pipeline
moved to [set-up-staging-production.md](set-up-staging-production.md)

# Background
## Status Quo (vor dem IC)
Der Zustand sowie die Deployment-Infrastuktur der IMI Map vor der Durchführung des Independent Courseworks war wie folgt:

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
Dabei soll jeder erfolgreiche CI-Build auf das Staging-System ausgerollt werden. Deployments auf das Produktivsystem
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

## Deployment
In den folgenden Abschnitten sollen die für das Deployment der Applikation genutzten Werkzeuge sowie
das Tooling um diese vorgestellt werden.

## Infrastruktur
Mit der Ansible-Konfiguration können, wie bereits im Setup beschrieben, Hosts für Staging und Production aufgesetzt werden.
Ansible setzt Folgendes auf:
- docker-engine und docker-compose
- einen Nginx-Webserver als Reverse Proxy vor der Rails-Applikation
- den SSH Key für das Continuous Deployment für den Deployment-User

Soll die Konfiguration von Nginx angepasst werden, muss die Datei `bootstrap_host/roles/nginx/templates/default.conf.j2` bearbeitet werden.

## Docker
Docker ist eine quelloffenes Projekt, welches es ermöglicht, beliebige Applikationen in sogenannten Containern zu deployen.
Hierzu nutzt Docker Virtualisierungs-Features auf Betriebssystemebene, sowie Ressourcenisolationsfeatures des Linux-Kernels.

Durch die Nutzung dieser Features fällt der Overhead, welcher beim Starten einer virtuellen Maschine anfällt, weg, da kein
weiteres Betriebssystem gestartet werden muss, sondern die Container über Dockers Bibliotheken den Kernel des Hostsystems selbst nutzen.
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
Alle anderen Umgebungen sind relevant für Continuous Integration und Continuous Delivery.

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
Der Quelltext der IMI-Map liegt in einem Git-Repository, welches auf GitHub gehostet ist. Das Repository ist auf GitHub so eingerichtet,
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
Für die von Travis durchgeführten Builds wurde Tooling in Ruby geschrieben. Die Tools sind im Ordner `ci-cd` zu finden.
Der Ablauf der Builds ist wiefolgt:
1. Entschlüsseln der SSH Deployment-Keys für Staging und Production
2. Korrigieren der Berechtigungen der Keys auf `0600`
3. Starten der Docker-Umgebung `test` mittels `docker-tool`. Die Tests werden hierbei innerhalb der Docker-Umgebung durchgeführt.

Die drei oben beschriebenen Schritte werden von Travis bei jeder Interaktion mit dem Git-Repository durchgeführt. Die nachfolgenden Schritte
werden nur ausgeführt, falls die Umgebung des Travis-Builds entweder ein [Tagged Release](https://help.github.com/articles/working-with-tags/) oder ein Commit in den
Master-Branch ist. Zusätzlich hierzu müssen die Tests in Schritt 3 erfolreich gewesen sein.

4. Erstellen eines Docker-Images für die neue Version der Applikation (`docker-build.rb`)
5. Pushen des Images in ein Repository auf [Docker Hub](https://hub.docker.com/u/imimaps/dashboard/) (`docker-push.rb`)
6. Deployment des neuen Images (`docker-deploy.rb`)

Sollte Travis erkennen, dass es sich bei dem aktuellen Commit um einen Tag handelt, wird der Deployment-Schritt auf dem Produktivsystem ausgeführt, andernfalls auf dem
Staging-System.


## Improvements
Auch am Zustand der IMI-Map nach der Durchführung des IC können noch viele Dinge verbessert werden. Die folgenden Abschnitte
schlagen einige Verbesserungen vor.


### Rails upgrade
Aktuell ist die Rails-Version der IMI-Map 3.2.13. Es empfiehlt sich ein Upgrade auf eine höhere Version, da dies unter anderem
die Performance aller `rake`-Commands erhöhen würde. Dies begründet sich darauf, dass ab Rails 4 [Spring](https://github.com/rails/spring),
ein Application Preloader direkt in Rails integriert ist. Der Vorteil ist, dass Spring die Applikation im Hintergrund am Laufen hält, sodass nicht
für jeden `rake`-Command der komplette Rails-Stack neu gestartet werden muss.

Der generelle Upgrade-Prozess für Rails-Applikationen ist in den [Rails Upgrade Guides](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html) beschrieben.
Durch die aktuell gegebene Testabdeckung sollte es relativ einfach sein, ein Upgrade durchzuführen.

### Remove Hardcoding
Die aktuelle Codebase weist an einigen stellen Hardcoding auf.

Beispiele:
- [LDAP Host](https://github.com/imimaps/imimaps/blob/master/app/controllers/user_verifications_controller.rb#L11)
- [Translations](https://github.com/imimaps/imimaps/blob/master/app/controllers/user_verifications_controller.rb#L16)
- [Downloads 1](https://github.com/imimaps/imimaps/blob/master/app/views/download/index.html.erb#L12-L15)
- [Downloads 2](https://github.com/imimaps/imimaps/blob/master/app/views/general/index.html.erb)

Dieses Hardcoding sollte entfernt und durch Konfigurationsdateien in `config/` ersetzt werden, um die Applikation wartbarer zu machen.

### Single Table Inheritance
Es gibt einige sehr ähnliche Models in der IMI-Map:
- `CertificateState`
- `ContractState`
- `InternshipState`
- `PaymentState`
- `RegistrationState`
- `ReportState`

Alle diese Models definieren exakt zwei Attribute (`name`, `name_de`) sowie eine `has_many`-Relation zum `Internships`-Model.
Es wäre möglich, diese Komplexität durch [Single Table Inheritance](http://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html) zu reduzieren.
Validiierungen könnten dann auf dem Basis-Model ausgeführt werden. Alle anderen Models würden dann nur noch von diesem Basis-Model erben.
Single Table Inheritance sollte nur dann genutzt werden, wenn sich die oben genannten Models nicht in absehbarer Zeit ändern werden.

### Proper naming
Es sollte beim Entwickeln darauf geachtet werden, dass Variablen vernünftige Namen erhalten. Andernfalls ist es für einen Entwickler schwierig,
den Code anderer Entwickler zügig zu verstehen.

Ein Beispiel für schlechte Benennung von Variablen findet sich [hier](https://github.com/imimaps/imimaps/blob/master/db/seeds.rb#L149-L161)

### Reduce complexity of methods
Einige Methoden sind in ihrem aktuellen Zustand eher schwer zu verstehen. Ein Beispiel für eine eher komplexe Methode findet sich
[hier](https://github.com/imimaps/imimaps/blob/master/app/controllers/quicksearches_controller.rb#L3).

Hohe Methodenkomplexität erschwert das Maintainen des Codes sowie das Erstellen von Tests für den Code. Aus diesem Grunde sollten Methoden einfach und präzise
sein. Siehe [KISS](https://en.wikipedia.org/wiki/KISS_principle).

### ElasticSearch als Search-Backend
Es wäre möglich, die IMI-Map mit dem [elasticsearch-rails](https://github.com/elastic/elasticsearch-rails)-Gem relativ einfach an ElasticSearch anzubinden.
Dieses Gem bietet eine einfache DSL für die Interaktion mit ElasticSearch und passt sich gut in ActiveModel bzw. ActiveRecord ein.

Vorteilhaft an der Verwendung des `elasticsearch-rails`-Gems wäre zum einen, dass beispielsweise die Komplexität von `QuicksearchesController`
deutlich reduziert werden könnte und zum anderen, dass die Search-Queries deutlich verständlicher wären.

### Routes
Im [Routing](https://github.com/imimaps/imimaps/blob/master/config/routes.rb) der IMI-Map befinden sich aktuell viele Routes, die nicht genutzt werden.
Viele Controller werden als RESTful Resources deklariert, obwohl sie dies überhaupt nicht sind.
Es bietet sich an, RESTful Routes, die nicht genutzt werden, gar nicht erst anzulegen und generell ungenutzte Routes zu entfernen.

### gmaps4rails
Das `gmaps4rails`-Gem benötigt ein Update. In der aktuellen Version versucht das Gem im View-Layer der Applikation externe JavaScript- sowie CSS-Assets
zu laden, welche nicht existieren. Das hat zur Folge, dass die GoogleMaps-Integration der IMI-Map aktuell nicht funktionieren kann.

### Rubocop
Um den gewünschten Code-Stil zu forcieren, Code-Linting zu betreiben oder Empfehlungen bezüglich Code-Performance zu erhalten,
wäre es eventuell sinnvoll, [Rubocop](http://rubocop.readthedocs.io/en/latest/cops/) in die Codebase einzubinden.

Tut man dies, wäre es ebenfalls möglich, Rubocop in der Continuous Integration laufen zu lassen und über deren Erfolg oder Misserfolg entscheiden zu lassen.

### Unused code, Unused Files, Unused Gems
Es befinden sich in der aktuellen Codebase nicht genutzter Code, nicht genutzte Dateien sowie nicht genutzte Gems.
Es wäre empfehlenswert jeglichen ungenutzten Code aus der Applikation zu entfernen.

### Strong Parameters
Sämtlicher Input, den eine Applikation von Benutzerseite bekommt, ist als potenziell gefährlich zu betrachten.
Aktuell findet in den Controllern der Applikation kein Filtering oder Sanitizing von Parametern an die Controller statt.

Genau dieses Filtering sollte durch die Nutzung von [Strong Parameters](https://github.com/rails/strong_parameters) eingeführt werden.
Dokumentation hierzu findet sich auch in den [Rails Guides](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters).

Referenzen:
  - https://xkcd.com/327/
  - http://www.codemag.com/article/0705061


### Erweiterung der Test-Suite
Die aktuelle Test-Suite könnte um weitere Tests sowie Test-Arten erweitert werden

Mögliche Frameworks, welche zusätzlich zum bereits im Projekt befindlichen RSpec eingesetzt werden könnten sind:
- [Cucumber](https://cucumber.io/)
- [Capybara](https://github.com/teamcapybara/capybara)

Sollte Capybara zum Einsatz kommen, solle es aus Gründen der Performance vorzugsweise mit Poltergeist oder capybara-webkit verwendet werden.

### Validations in Models
Viele Models der IMI-Map validieren nur, ob ihre Attribute vorhanden sind oder nicht. Dies ist zwar für die Validierung
von Model-Objekten ein notwendiger Schritt, er ist aber in keiner Weise hinreichend:

Es ist aktuell ohne Probleme möglich sich mit Email-Adressen zu registrieren, die aufgrund ihres Formates überhaupt nicht existieren können.
Ebenfalls werden könnte sich ein Nutzer mit dem Vornamen C3PO anmelden, ohne dass die Validierung der Models fehlschlagen würde.

Alle Attribute aller Models sollten mit Validierungen versehen werden.

### Database Seeds mit FactoryGirl
Da FactoryGirl in der Test-Suite bereits eingesetzt wird und Factories für alle Models bestehen, bietet es sich an, diese Factories
auch für die Seeds der Datenbank zu nutzen. Dies würde die Datei `seeds.rb` deutlich verkürzen und übersichtlicher machen.

### SSL
Es ist aus Gründen der Datensicherheit zu empfehlen, dass die Kommunikation zwischen Applikation und Benutzer über einen sicheren Kanal verläuft.
Deswegen sollte die Nginx-Konfiguration - zumindest für das Produktivsystem - so erweitert werden, dass der virtuelle Host zur Kommunikation SSL verwendet.

## Lessons learned
Ich persönlich habe in dem IC einige Dinge gelernt. So war mir beispielsweise das oben beschriebene Problem mit FactoryGirl, welches durch die 1:1-Beziehung zwischen
Student-Model und User-Model entstand, nicht bekannt.

Weiterhin habe ich in meinem beruflichen Umfeld zwar bereits mit den in den eingesetzten Tools Docker, Docker Compose, Travis und Ansible gearbeitet, allerdings war es für mich
durchaus eine Herausforderung, eine CI/CD Pipeline auf Basis dieser Tools selbst von Grund auf neu aufzusetzen, da ich bis jetzt immer mit bereits bestehenden Systemen gearbeitet habe.

Ich habe den Eindruck, dass ich durch die Durchführung des Independent Coursework ein deutlich tieferes Verständnis der oben genannten Werkzeuge erlangt habe,
gerade deswegen, weil ich nicht mit einem bereits bestehenden System gearbeitet, sondern ein neues erstellt habe.

Dies wird mir in meiner weiteren beruflichen Laufbahn sicherlich erlauben, mit den Tools der DevOps-Toolchain souveräner umzugehen als es vor dem Independent Coursework der Fall war.

## References
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Thor](http://whatisthor.com/)
- [Travis](https://travis-ci.org/)
- [Ansible](https://www.ansible.com/)
- [Vagrant](https://www.vagrantup.com/)
