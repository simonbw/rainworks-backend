require "administrate/base_dashboard"

class RainworkDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    device: Field::BelongsTo,
    reports: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    creator_name: Field::String,
    creator_email: Field::String,
    description: Field::Text,
    image_url: Field::Text,
    approval_status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    active: Field::Boolean,
    lat: Field::Number.with_options(decimals: 2),
    lng: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    report_count: Field::Number,
    found_it_count: Field::Number,
    faded_count: Field::Number,
    missing_count: Field::Number,
    inappropriate_count: Field::Number,
    installation_date: Field::DateTime,
    rejection_reason: Field::Text,
    thumbnail_url: Field::String,
    show_in_gallery: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    device
    reports
    id
    name
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    device
    reports
    id
    name
    creator_name
    creator_email
    description
    image_url
    approval_status
    active
    lat
    lng
    created_at
    updated_at
    report_count
    found_it_count
    faded_count
    missing_count
    inappropriate_count
    installation_date
    rejection_reason
    thumbnail_url
    show_in_gallery
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    device
    reports
    name
    creator_name
    creator_email
    description
    image_url
    approval_status
    active
    lat
    lng
    report_count
    found_it_count
    faded_count
    missing_count
    inappropriate_count
    installation_date
    rejection_reason
    thumbnail_url
    show_in_gallery
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how rainworks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(rainwork)
  #   "Rainwork ##{rainwork.id}"
  # end
end
