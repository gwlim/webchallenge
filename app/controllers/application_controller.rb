class ApplicationController < ActionController::Base
  layout "application"
before_filter  :set_locale, :authenticate_student!, :except => [
:index,:student_prizes,
:student_session,:new_student_session,
:student_registration,:new_student_registration,:administrator_session_path,:new_administrator_session_path]

  protect_from_forgery

	def set_locale
	  if student_signed_in?
	    params[:locale] = current_student.language
	    I18n.locale = current_student.language
	  else
	  I18n.locale = params[:locale]||I18n.default_locale
	  end
	end

	def default_url_options(options={})
	  { :locale => I18n.locale }
	end
	
	def check_recaptcha 
		if (Rhconfig.first.disable_recaptcha==true)
			return true
		else
			return false
		end
	end

end
