# frozen_string_literal: true
require 'byebug'

$LOAD_PATH << '../lib'

Dir[Dir.pwd + "/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Helpers::Board
end
