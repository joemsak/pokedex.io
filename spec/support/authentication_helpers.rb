module AuthenticationHelpers
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
  end

  def sign_out
    allow_any_instance_of(ApplicationController).to receive(:current_user) { nil }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers
end
