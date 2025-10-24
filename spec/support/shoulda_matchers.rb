# frozen_string_literal: true

require 'shoulda/matchers'

Shoulda::Matchers.configure do |matchers|
  matchers.integrate do |with|
    with.test_framework :rspec

    # This require statement solves the uninitialized constant / NameError issue
    require 'active_record'
    with.library :active_record
    with.library :active_model
  end
end
