class Rainwork < ApplicationRecord
  enum approval_status: [:pending, :accepted, :rejected, :expired]
  attr_default :approval_status, :pending
  has_many :reports
end
