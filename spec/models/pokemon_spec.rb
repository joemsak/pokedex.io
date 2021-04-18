require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  let!(:pokemon) { create(:pokemon) }

  describe "#name" do
    it "is required" do
      pokemon.update(name: nil)

      expect(pokemon).not_to be_valid
      expect(pokemon.errors.size).to be 1
      expect(pokemon.errors[:name]).to eq(["can't be blank"])
    end

    it "must be unique" do
      pokemon2 = build(:pokemon, name: pokemon.name)

      expect(pokemon2).not_to be_valid
      expect(pokemon2.errors.size).to be 1
      expect(pokemon2.errors[:name]).to eq(["has already been taken"])
    end

    it "powers the slug" do
      expect(pokemon.slug).to eq(pokemon.name.parameterize)
    end
  end

  describe "#external_id" do
    it "is required" do
      pokemon.update(external_id: nil)

      expect(pokemon).not_to be_valid
      expect(pokemon.errors.size).to be 1
      expect(pokemon.errors[:external_id]).to eq(["can't be blank"])
    end

    it "must be unique" do
      pokemon2 = build(:pokemon, external_id: pokemon.external_id)

      expect(pokemon2).not_to be_valid
      expect(pokemon2.errors.size).to be 1
      expect(pokemon2.errors[:external_id]).to eq(["has already been taken"])
    end
  end

  describe "#image_url" do
    it "is required" do
      pokemon.update(image_url: nil)

      expect(pokemon).not_to be_valid
      expect(pokemon.errors.size).to be 1
      expect(pokemon.errors[:image_url]).to eq(["can't be blank"])
    end

    it "must be unique" do
      pokemon2 = build(:pokemon, image_url: pokemon.image_url)

      expect(pokemon2).not_to be_valid
      expect(pokemon2.errors.size).to be 1
      expect(pokemon2.errors[:image_url]).to eq(["has already been taken"])
    end
  end
end
