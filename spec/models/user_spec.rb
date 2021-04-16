require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#email" do
    it "must be unique" do
      user = create(:user, email: "hello@world.com")
      user2 = build(:user, email: "hello@world.com")

      expect(user2).not_to be_valid
      expect(user2.errors.size).to be 1
      expect(user2.errors[:email]).to eq(["has already been taken"])
    end
  end
end
