class Rainwork < ApplicationRecord
  enum approval_status: [:pending, :accepted, :rejected]
  attr_default :approval_status, :pending
  attr_default :active, false
end
