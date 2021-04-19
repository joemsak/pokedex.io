require 'net/http'

#
# TODO: Next cycle: https://github.com/rdavid1099/poke-api-v2
#
#

#
# FROM POKEAPI DOCS:
#
# No authentication is required to access this API, and all resources are fully
# open and available.
#
# Since the move to static hosting in November 2018, rate limiting has been
# removed entirely, but we still encourage you to limit the frequency of requests
# to limit our hosting costs.
#
# TODO: Schedule on server once a week at most
#
namespace :pokeapi do
  desc "Sync from Pokeapi.co, create or update existing PokemonImports"
  task sync: :environment do
    import_pages("https://pokeapi.co/api/v2/pokemon")
  end

  def import_pages(url)
    return unless url

    resp = Net::HTTP.get_response(URI(url))
    page = JSON.parse(resp.read_body)

    page["results"].each do |result|
      PokemonImportJob.perform_later(result)
    end

    import_pages(page["next"])
  end
end
