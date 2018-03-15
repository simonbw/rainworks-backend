class Device < ApplicationRecord
  enum initial_submission_status: [:pending, :accepted, :rejected]
  attr_default :initial_submission_status, :pending
  has_many :rainworks
  has_many :reports
end
