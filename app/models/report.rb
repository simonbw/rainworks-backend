class Report < ApplicationRecord
  belongs_to :rainwork
  enum report_type: [:found_it, :missing, :faded, :inappropriate]
end
