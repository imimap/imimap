**Travis CI**
[![Build Status](https://travis-ci.org/imimaps/imimaps.svg?branch=master)](https://travis-ci.org/imimaps/imimaps)

The [IMI Map](http://imi-map.f4.htw-berlin.de) supports students at the University of Applied Sciences Berlin in finding an internship abroad.

The project was developed as part of the study of international media and computer sience.

## Development Setup
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
$ bundle install
$ gem install thor

# start the development environment
$ ./docker-tool development start

# Open the application in your browser
$ open http://localhost:8080
