class StudentsController < ApplicationController
	before_action :check_view_privilege, only: [:index, :show]
	before_action :check_update_privilege, only: [:add_to_batch]

	def index
		students = Students.where(batch_id: params['batch_id'])
		respond_to do |format|
			format.json do 
				render json: { students: students }
			end
		end
	end

	def show
		student = Students.find(params['id'])
		respond_to do |format|
			format.json do 
				render json: { students: student }
			end
		end
	end


	def add_to_batch
		student = Student.find(params['id'])
		student.attributes = student_params
		resp = student.save
		raise AppErrors::Custom, message: 'Failed to create enrollment', status: 400 unless resp
		respond_to do |format|
			format.json do 
				render json: { message: 'Success' }
			end
		end 
	end

	private

	def student_params
		params.require('student').permit('batch_id')
	end
	
	def check_index_privilege
		raise AppErrors::Unauthorized unless current_user.role.privilege?(:view_students)
	end

	def check_update_privilege
		raise AppErrors::Unauthorized unless current_user.role.privilege?(:add_to_batch)
	end
end
