require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe "syncing attributes before saving" do
    let(:json) { JSON.parse(File.read("./spec/support/api_data/pokemon_detail.json")) }

    let!(:pokemon) { create(:pokemon, imported_data: json) }

    describe "#name" do
      it "is derived from #imported_data" do
        expect(pokemon.name).to eq("Bulbasaur")
      end
    end

    describe "#external_id" do
      it "is derived from #imported_data" do
        expect(pokemon.external_id).to eq(1)
      end
    end

    describe "#image_url" do
      it "is derived from #imported_data" do
        expect(pokemon.image_url).to eq(
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        )
      end
    end
  end

  describe "#imported_data" do
    it "updates #imported_at when it changes" do
      pokemon = create(:pokemon)

      freeze_time do
        expect {
          pokemon.update(imported_data: {})
        }.to change {
          pokemon.imported_at
        }.from(nil).to(Time.current)
      end
    end
  end
end
