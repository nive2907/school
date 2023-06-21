class SchoolAdminController < ApplicationController
	before_action :check_privilege

	def create
		school_admin = SchoolAdmin.new(school_admin_params)
		resp = school_admin.save
		raise AppErrors::Custom, message: 'Failed to create school admin', status: 400 unless resp
		respond_to do |format|
			format.json do 
				render json: { id: school_admin.id }
			end
		end
	end

	private

	def school_admin_params
		params.require('school_admin').permit('name', 'role_id')
	end

	def check_privilege
		raise ::AppErrors::Unauthorized unless current_user.role.privilege?(:create_school_admin)
	end
end
