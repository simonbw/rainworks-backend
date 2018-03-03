class Report < ApplicationRecord
  belongs_to :rainwork
  belongs_to :device
  enum report_type: [:found_it, :missing, :faded, :inappropriate]

  counter_culture :rainwork, column_name: 'report_count'
  counter_culture :rainwork, column_name: proc {|report| "#{report.report_type}_count"}
end
