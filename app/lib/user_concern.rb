module UserConcern
	USER_TYPES = {
		admin: Admin,
		school_admin: SchoolAdmin,
		student: Student
	}

	def set_current_user
		user_model = USER_TYPES[params['user_type'].underscore.to_sym]
		current_user = user_model.find(params['user_id'])
		Thread.current[:current_user] = current_user
	end

	def current_user
		Thread.current[:current_user]
	end
end