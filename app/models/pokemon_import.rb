class PokemonImport < ApplicationRecord
  has_one :pokemon

  delegate :imported_at,
    to: :pokemon,
    prefix: true,
    allow_nil: false

  after_commit :sync_pokemon, if: :needs_data_sync?

  def sync_pokemon
    build_pokemon unless pokemon

    pokemon.update(
      name: name,
      external_id: external_id,
      image_url: image_url,
      imported_at: Time.current,
    )
  end

  def name
    data.fetch(:name) { "not found" }.titleize
  end

  def external_id
    data.fetch(:id) { -Time.current.to_i }
  end

  def image_url
    #
    # TODO: provide a missing image asset
    #
    data.dig(:sprites, :front_default) ||
      data.dig(:sprites, :other, "official-artwork", :front_default) ||
        "missing-#{SecureRandom.hex(8)}.png"
  end

  def data
    read_attribute(:data).with_indifferent_access
  end

  private
  def needs_data_sync?
    saved_change_to_data? && data.present?
  end
end
