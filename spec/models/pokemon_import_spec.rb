require 'rails_helper'

RSpec.describe PokemonImport, type: :model do
  let(:json) { JSON.parse(File.read("./spec/support/api_data/pokemon_detail.json")) }

  let!(:import) { create(:pokemon_import, data: json) }

  let(:pokemon) { import.pokemon }

  describe "creating/syncing an associated pokemon record" do
    describe "#name" do
      it "is derived from #data" do
        expect(pokemon.name).to eq("Bulbasaur")
      end
    end

    describe "#external_id" do
      it "is derived from #data" do
        expect(pokemon.external_id).to eq(1)
      end
    end

    describe "#image_url" do
      it "is derived from #data" do
        expect(pokemon.image_url).to eq(
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        )
      end
    end
  end

  describe "#data" do
    it "updates the pokemon's #imported_at when it changes" do
      freeze_time do
        expect {
          import.update(data: { empty: false })
        }.to change {
          import.pokemon_imported_at
        }.to(Time.current)
      end
    end
  end
end
