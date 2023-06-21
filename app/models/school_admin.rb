class SchoolAdmin < ApplicationRecord
	has_one :user_role, -> {where(user_type: 'SchoolAdmin')}, foreign_key: 'user_id'
	has_one :role, through: :user_role
	attr_accessor :role_id

	def role_id=(id)
		self.role = Role.find(id)
	end
end
