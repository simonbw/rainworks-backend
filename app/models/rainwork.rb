class Rainwork < ApplicationRecord
  enum approval_status: [:pending, :accepted, :rejected, :expired, :edit_pending]
  attr_default :approval_status, :pending
  attr_default :show_in_gallery, true
  belongs_to :device
  has_many :reports
end
