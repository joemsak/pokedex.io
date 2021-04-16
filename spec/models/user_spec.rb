require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#email" do
    it "must be unique" do
      user = create(:user, email: "hello@world.com")
      expect(build(:user, email: "hello@world.com")).not_to be_valid
    end
  end
end
