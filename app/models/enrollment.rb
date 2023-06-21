class Enrollment < ApplicationRecord
	belongs_to :school
	belongs_to :batch
	belongs_to :student, foreign_key: 'user_id'
	
	STATUS = {
		initiatiated: 0,
		approved: 1,
		rejected: 2
	}
end
