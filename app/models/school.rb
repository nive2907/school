class School < ApplicationRecord
	has_many :batches
	has_many :courses
	has_many :enrollments
	has_many :students
end
