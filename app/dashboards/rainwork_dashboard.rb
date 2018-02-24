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
    creator_email: Field::String,
    description: Field::Text,
    image_url: Field::Image,
    approval_status: Field::Enum,
    active: Field::Boolean,
    lat: Field::LatLng,
    lng: Field::LatLng,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :created_at,
    :name,
    :creator_name,
    :creator_email,
    :approval_status,
    :active
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :creator_name,
    :creator_email,
    :description,
    :image_url,
    :approval_status,
    :active,
    :lat,
    :lng,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :creator_name,
    :creator_email,
    :description,
    :image_url,
    :lat,
    :lng,
    :approval_status,
    :active,
  ].freeze

  # Overwrite this method to customize how rainworks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(rainwork)
  #   "Rainwork ##{rainwork.id}"
  # end
end
