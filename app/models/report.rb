class Report < ApplicationRecord
  belongs_to :rainwork
  belongs_to :device
  enum report_type: [:found_it, :missing, :faded, :inappropriate]
end
