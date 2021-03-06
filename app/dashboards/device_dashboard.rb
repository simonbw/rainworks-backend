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
    initial_submission_status: Field::Enum,
    nickname: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :nickname,
    :device_uuid,
    :rainworks,
    :reports,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :nickname,
    :initial_submission_status,
    :device_uuid,
    :push_token,
    :created_at,
    :updated_at,
    :reports,
    :rainworks,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :nickname,
    :initial_submission_status,
    :device_uuid,
    :push_token,
  ].freeze

  # Overwrite this method to customize how devices are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(device)
    if device.nickname
      return "#{device.nickname} (#{device.device_uuid})"
    end
    "Device (#{device.device_uuid})"
  end
end
