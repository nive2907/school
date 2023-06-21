class ApplicationController < ActionController::Base
	include ::UserConcern
	before_action :set_current_user
end
