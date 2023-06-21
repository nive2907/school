class SchoolsController < ApplicationController
	before_action :check_create_privilege, only: [:create]
	before_action :check_update_privilege, only: [:update]

	def create
		school = School.new(school_params)
		resp = school.save

		raise AppErrors::Custom, message: 'Failed to create school', status: 400 unless resp
		respond_to do |format|
			format.json do 
				render json: { id: school.id }
			end
		end
	end

	def update
		school = School.find(params['id'])
		school.attributes = school_params
		resp = school.save
		raise AppErrors::Custom, message: 'Failed to update school', status: 400 unless resp
		respond_to do |format|
			format.json do 
				render json: { message: 'Success' }
			end
		end
	end

	private

	def school_params
		params.require('school').permit('name')
	end

	def check_create_privilege
		raise AppErrors::Unauthorized unless current_user.role.privilege?(:create_school)
	end

	def check_update_privilege
		raise AppErrors::Unauthorized unless current_user.role.privilege?(:update_school)
	end
end
