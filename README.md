# Chit Chat API

A simple rest chat API for [chit-chat](https://github.com/kanaydo/chit-chat) simple chat application using flutter.

build using:
```
* rails 6.0.0
* ruby 2.5.1
```

## Setup
- installations:
install [Ruby and Ruby on Rails](https://gorails.com/setup/ubuntu/18.04) by following the instructions.
and install the redis-server:
```
sudo apt-get install redis-server
```
- clone:
```
git clone https://github.com/kanaydo/chit-chat-api.git
```

- install dependency:
```
- bundle install
```

- set database:
```
rename config/database.yml.template to config/database.yml then set postgresql credential to your own.
```

- create database:
```
rake db:create
```

- migrate database:
```
rake db:migrate
```

- run server
```
rails s -b 0.0.0.0
```
