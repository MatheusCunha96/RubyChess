install:
	bundle install

run:
	ruby lib/game.rb

test:
	RAILS_ENV=test coverage=on bundle exec rspec spec

