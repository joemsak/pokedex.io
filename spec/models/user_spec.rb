require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "#username" do
    it "is required" do
      user.update(username: nil)

      expect(user).not_to be_valid
      expect(user.errors.size).to be 1
      expect(user.errors[:username]).to eq(["can't be blank"])
    end

    it "must be unique" do
      user2 = build(:user, username: user.username)

      expect(user2).not_to be_valid
      expect(user2.errors.size).to be 1
      expect(user2.errors[:username]).to eq(["has already been taken"])
    end

    it "powers the slug" do
      expect(user.slug).to eq(user.username.parameterize)
    end
  end

  describe "#email" do
    it "is required" do
      user.update(email: nil)

      expect(user).not_to be_valid
      expect(user.errors.size).to be 2
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "must be unique" do
      user2 = build(:user, email: user.email)

      expect(user2).not_to be_valid
      expect(user2.errors.size).to be 1
      expect(user2.errors[:email]).to eq(["has already been taken"])
    end

    it "must be an email" do
      user.update(email: "foo")

      expect(user).not_to be_valid
      expect(user.errors.size).to be 1
      expect(user.errors[:email]).to eq(["is invalid"])

      user.update(email: "foo@bar")

      expect(user).not_to be_valid
      expect(user.errors.size).to be 1
      expect(user.errors[:email]).to eq(["is invalid"])

      user.update(email: "foo+trick@example.com")

      expect(user).to be_valid
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
