require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "#email" do
    it "must be unique" do
      user2 = build(:user, email: user.email)

      expect(user2).not_to be_valid
      expect(user2.errors.size).to be 1
      expect(user2.errors[:email]).to eq(["has already been taken"])
    end
  end

  describe "#password" do
    it "is driven by has_secure_password" do
      user.update(password: "testing123", password_confirmation: "testing123")

      expect(user.password_digest).not_to be_blank
      expect(user.authenticate("foo")).to be false
      expect(user.authenticate("testing123")).to eq(user)
    end
  end

  describe "#auth_token" do
    it "is driven by has_secure_token" do
      expect(user.auth_token).not_to be_blank

      expect {
        user.regenerate_auth_token
      }.to change {
        user.auth_token
      }
    end
  end
end
