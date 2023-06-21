class CoursesController < ApplicationController
	before_action :check_privilege

	def create
		course = Course.new(course_params)
		resp = course.save

		raise ::AppErrors::Custom, message: 'Failed to create course', status: 400 unless resp
		respond_to do |format|
			format.json do 
				render json: { id: course.id }
			end
		end
	end

	private

	def course_params
    params.require('course').permit('school_id', 'name')
  end

	def check_privilege
		raise ::AppErrors::Unauthorized unless current_user.role.privilege?(:create_course)
	end
end
