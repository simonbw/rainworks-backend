require "administrate/base_dashboard"

class DeviceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    device_uuid: Field::String,
    rainworks: Field::HasMany,
    reports: Field::HasMany,
    push_token: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    initial_submission_status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    nickname: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    nickname
    device_uuid
    rainworks
    reports
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    nickname
    initial_submission_status
    device_uuid
    push_token
    created_at
    updated_at
    reports
    rainworks
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    nickname
    initial_submission_status
    device_uuid
    push_token
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

  # Overwrite this method to customize how devices are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(device)
    if device.nickname
      return "#{device.nickname} (#{device.device_uuid})"
    end
    "Device #(#{device.device_uuid})"
  end
end
