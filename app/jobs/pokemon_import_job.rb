require 'net/http'

class PokemonImportJob < ApplicationJob
  queue_as :default

  def perform(api_page_result)
    url = api_page_result["url"]
    resp = Net::HTTP.get_response(URI(url))

    import = PokemonImport.find_or_initialize_by(url: url)

    import.update(data: JSON.parse(resp.read_body))
  end
end
