class Rainwork < ApplicationRecord
	enum approval_status: [:pending, :accepted, :rejected]
end
