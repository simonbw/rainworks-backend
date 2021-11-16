require "administrate/base_dashboard"

class RainworkDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    creator_name: Field::String,
    description: Field::Text,
    image_url: Field::Image,
    thumbnail_url: Field::Image,
    approval_status: Field::Enum,
    active: Field::Boolean,
    lat: Field::LatLng,
    lng: Field::LatLng,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    installation_date: Field::DateTime,
    device: Field::BelongsTo,
    reports: Field::HasMany,
    report_count: Field::Number,
    found_it_count: Field::Number,
    missing_count: Field::Number,
    faded_count: Field::Number,
    inappropriate_count: Field::Number,
    rejection_reason: Field::Text,
    show_in_gallery: Field::Boolean,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  COLLECTION_ATTRIBUTES = [
    :created_at,
    :installation_date,
    :name,
    :creator_name,
    :approval_status,
    :report_count,
    :found_it_count,
    :show_in_gallery,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :approval_status,
    :show_in_gallery,
    :name,
    :creator_name,
    :description,
    :image_url,
    :thumbnail_url,
    :lat,
    :lng,
    :installation_date,
    :device,
    :reports,
    :report_count,
    :found_it_count,
    :missing_count,
    :faded_count,
    :inappropriate_count,
    :created_at,
    :updated_at,
    :rejection_reason,
    :id,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :creator_name,
    :installation_date,
    :description,
    :device,
    :image_url,
    :thumbnail_url,
    :lat,
    :lng,
    :approval_status,
    :show_in_gallery,
  ]

  # Overwrite this method to customize how rainworks are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(rainwork)
    "RW \"#{rainwork.name}\""
  end
end
