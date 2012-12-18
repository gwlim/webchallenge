ActiveAdmin.register Rhconfig, :as => "Application Configuration" do
menu :parent => "Application",:priority => 1
if Rhconfig.table_exists?
  config.sort_order = "id_asc"
#	config.clear_action_items!
	config.clear_sidebar_sections!
	actions :all, :except => [:destroy]
	index do
		column :id
		column :country
		column :total_qn
		column :qn_per_topic
		if !(Rhconfig.first.add_diff_qn.nil?)
		column :add_diff_qn
		end
		if !(Rhconfig.first.add_norm_qn.nil?)
		column :add_norm_qn
		end
		if !(Rhconfig.first.add_easy_qn.nil?)
		column :add_easy_qn
		end
		column :time_limit
		column :registration_start
		column :registration_end
		column ("Manual Registration") {|ro| status_tag (ro.registration_override ? "ENABLED" : "DISABLED"), (ro.registration_override ? 'ok' :'error')unless ro.registration_override.blank?}
		column ("Registration Control") {|rc| status_tag (rc.registration_override ? "ON" : "OFF"), (rc.registration_override ? 'ok'  :'error')unless rc.registration_override.blank?}
		column :challenge_start
		column :challenge_end
		column ("Manual Challenge") {|co| status_tag (co.registration_override ? "ENABLED" : "DISABLED"), (co.registration_override ? 'ok' : 'error')unless co.registration_override.blank?}
		column ("Challenge Control") {|cc| status_tag (cc.registration_override ? "ON" : "OFF"), (cc.registration_override ? 'ok' : 'error')unless cc.registration_override.blank?}
		if !(Rhconfig.first.extend_time.nil?)
		column :extend_time
		end
		column ("Disable Recaptcha") {|r| status_tag (r.disable_recaptcha ? "ENABLED" : "DISABLED"), (r.disable_recaptcha ?  'warning':'ok' )unless r.disable_recaptcha.nil?}
		column :default_credential
		default_actions
	  	end
  end
end
