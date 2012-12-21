ActiveAdmin.register Appconfig, :as => "Application Configuration" do
menu :parent => "Application",:priority => 1
if Appconfig.table_exists?
  config.sort_order = "id_asc"
#	config.clear_action_items!
	config.clear_sidebar_sections!
	actions :all, :except => [:destroy]
	index do
		column :id
		column ("Enable Recaptcha") {|r| status_tag (r.enable_recaptcha ? "ENABLED" : "DISABLED"), (r.enable_recaptcha ?  'ok':'warning' )unless r.enable_recaptcha.nil?}
		column :default_password
		column :registration_start
		column :registration_end
		column ("Manual Registration") {|ro| status_tag (ro.registration_override ? "ENABLED" : "DISABLED"), (ro.registration_override ? 'ok' :'error')unless ro.registration_override.nil?}
		column ("Registration Control") {|rc| status_tag (rc.registration_override ? "OFF" : "ON"), (rc.registration_override ? 'error'  :'ok')unless rc.registration_override.nil?}
		default_actions
	  	end
  end
end
