class EnrollmentsController < ApplicationController
	before_action :check_create_privilege, only: [:create]
	before_action :check_approve_privilege, only: [:approve]

	def create
		enrollment = Enrollment.new(enroll_params)
		resp = enrollment.save
		raise AppErrors::Custom, message: 'Failed to create enrollment', status: 400 unless resp
		respond_to do |format|
			format.json do 
				render json: { id: enrollment.id }
			end
		end
	end

	def approve
		enrollment = Enrollment.find(params['id'])
		enrollment.attributes = enroll_params
		resp = enrollment.save
		raise AppErrors::Custom, message: 'Failed to update enrollment status', status: 400 unless resp

		if enrollment.status = Enrollment::STATUS[:approved]
			student = enrollment.student
			student.batch_id = enrollment.batch_id
			student.save
		end
		respond_to do |format|
			format.json do 
				render json: { id: enrollment.id }
			end
		end
	end

	private

	def enroll_params
		params.require('enrollment').permit('school_id', 'batch_id', 'user_id', 'status')
	end

	def check_create_privilege
		raise AppErrors::Unauthorized unless current_user.role.privilege?(:create_enrollment)
	end

	def check_approve_privilege
		raise AppErrors::Unauthorized unless current_user.role.privilege?(:update_enrollment)
	end
end
