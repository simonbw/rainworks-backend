class Device < ApplicationRecord
  has_many :rainworks
  has_many :reports
end
