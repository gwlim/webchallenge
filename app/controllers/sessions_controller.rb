class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  prepend_before_filter { request.env["devise.skip_timeout"] = true }

  # GET /resource/sign_in
  def new
    resource = build_resource(nil, :unsafe => true)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    reset_session
#warden have to authenticate first
    resource = warden.authenticate!(auth_options)
	#Create Questions if not present
    #set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    if !current_student.challenge.nil? && current_student.challenge.completed==true
      redirect_path = after_complete_sign_out_path_for(resource_name)
    else  
    redirect_path = after_sign_out_path_for(resource_name)
    end
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
	head :no_content
      end
    end
  end

  protected

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end

  def after_sign_in_path_for(resource)
     student_root_path

  end
	
  def after_sign_out_path_for(resource_or_scope)
	new_session_path(resource_name)
  end
  
  def after_complete_sign_out_path_for(resource)
	if (current_student.language=="zh-CN")
	  return "http://www.example.com"
	elsif (current_student.language=="zh-TW")
	  return "http://www.example.com"
	else
	  return "http://www.example.com"
	end
  end
end



