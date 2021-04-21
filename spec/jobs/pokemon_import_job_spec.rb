require 'rails_helper'

RSpec.describe PokemonImportJob, type: :job do
  describe "#perform" do
    let(:data) { File.read("./spec/support/api_data/pokemon_detail.json") }

    let(:result) { raise 'define a { "url" => "value" } hash for your context' }

    let(:url) { result["url"] }

    before { stub_request_response(url, body: data) }

    context "for a new URL" do
      let(:result) { { "url" => "https://example.org/api/v2/pokemon/1" } }

      it "creates a pokemon import" do
        expect {
          PokemonImportJob.new.perform(result)
        }.to change {
          PokemonImport.count
        }.from(0).to(1)

        import = PokemonImport.last

        expect(import.url).to eq(url)
        expect(import.data).to eq(JSON.parse(data))
      end
    end

    context "for a matching URL" do
      let(:import) { create(:pokemon_import) }
      let(:result) { { "url" => import.url } }

      it "updates existing pokemon imports" do
        expect {
          PokemonImportJob.new.perform(result)
        }.not_to change {
          PokemonImport.count
        }.from(1)

        expect(import.reload.data).to eq(JSON.parse(data))
      end
    end
  end
end
