class Student < ApplicationRecord
	belongs_to :school
	belongs_to :batch, optional: true
	has_many :enrollments
	has_one :user_role, -> { where(user_type: 'Student') }, foreign_key: 'user_id'
	has_one :role, through: :user_role
	attr_accessor :role_id

	def role_id=(id)
		self.role = Role.find(id)
	end
end
