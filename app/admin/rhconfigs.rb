ActiveAdmin.register Rhconfig, :as => "Challenge Configuration" do
menu :parent => "Application",:priority => 2
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
		column :challenge_start
		column :challenge_end

		column ("Manual Challenge") {|co| status_tag (co.challenge_override ? "ENABLED" : "DISABLED"), (co.challenge_override ? 'ok' : 'error') unless co.challenge_override.nil?}
		column ("Challenge State") {|cs| status_tag (cs.challenge_on ? "ACTIVE" : "INACTIVE"), (cs.challenge_override ? 'ok' : 'error') unless cs.challenge_on.nil?}
		column ("Challenge Control") {|cc| status_tag (cc.challenge_override ? "OFF" : "ON"), (cc.challenge_override ? 'error' : 'ok') unless cc.challenge_override.nil?}
		default_actions
	  	end
  end
end
