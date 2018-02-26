class Rainwork < ApplicationRecord
  after_initialize :init
  enum approval_status: [:pending, :accepted, :rejected]

  def init
    self.approval_status ||= :pending
    self.active ||= false
  end
end
