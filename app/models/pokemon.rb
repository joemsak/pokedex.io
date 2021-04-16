class Pokemon < ApplicationRecord
  before_save :sync_imported_attributes, if: :needs_imported_data_sync?
  before_save :set_imported_at_now, if: :imported_data_changed?

  def imported_data
    read_attribute(:imported_data).with_indifferent_access
  end

  private
  def sync_imported_attributes
    sync_name
    sync_external_id
    sync_image_url
    set_imported_at_now
  end

  def sync_name
    self.name = imported_data[:name].titleize
  end

  def sync_external_id
    self.external_id = imported_data[:id]
  end

  def sync_image_url
    self.image_url = imported_data[:sprites][:front_default]
  end

  def needs_imported_data_sync?
    imported_data_changed? && imported_data.present?
  end

  def set_imported_at_now
    self.imported_at = Time.current
  end
end
