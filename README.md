# Description
Blog REST JSON API created with an alternative approach using concepts and repositories

# Requirements
* PostgreSQL server running

# Installation
* `bundle`
* set DB credentials in `database.yml`
* `bin/rake db:create db:migrate`
* `bin/rails s`

# Testing

To test manually I used Postman. If you wish to recreate my tests I saved my requests into a shareable collection, which you can
get under this link https://www.getpostman.com/collections/00324c1c5ebcb7c24914

To test automatically run rspec tests `bin/rspec`
