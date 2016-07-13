# Getting Started

1. `cp config/database.yml.sample config/database.yml`
2. `cp config/secrets.yml.sample config/secrets.yml`
3. `bundle install --path vendor/bundle --without production --jobs 4`
4. `bin/rake db:create db:migrate db:seed`
5. `bin/rails s`
6. start development!!
