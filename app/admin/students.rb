ActiveAdmin.register Student do
if Student.table_exists?
  config.per_page = 100
  config.sort_order = "id_asc"
  menu :parent => "Student Information",:priority => 1

	scope :activated
	scope :inactivated
	scope :joined, :default => true do |fields|
			fields.includes [:challenge]
		end

	filter :id, :as => :select, :collection => Student.find(:all, :select => 'students.id').collect{|student| student.id}.sort , :label => 'Student ID Number'
	filter :id
	#filter :email, :as=>:select, :collection => Student.all.map(&:email)
	filter :email
	filter :first_name
	filter :last_name
	filter :contact_number
	filter :school, :as => :select, :collection => Student.find(:all, :select => 'students.school').collect{|student| student.school}.uniq.sort
	filter :country, :as => :select, :collection => Student.find(:all, :select => 'students.country').collect{|student| student.country}.uniq.sort
	filter :language, :as => :select, :collection => Student.find(:all, :select => 'students.language').collect{|student| student.language}.uniq.sort
	filter :lecturer_name
	filter :lecturer_email
	filter :challenge_completed, :as => :select
	filter :challenge_total_score, :as => :numeric
	filter :challenge_time_limit

	batch_action :reset_password_of, :confirm => "Are you sure you want to reset password of selected students?" do |selection|
	    @list=String.new
		Student.find(selection).each do |student|
		student.reset_password
		@list << "[#{student.email.to_s}]"
	    end
	    redirect_to rhchallenge_administration_students_path, :notice => "#{@list.to_s} passwords have been resetted to #{Rhconfig.first.default_credential}"
	end

	batch_action :reset_challenge_of, :confirm => "Are you sure you want to reset the challenge of selected students?" do |selection|
	    @list=String.new
		Student.find(selection).each do |student|
		if !student.challenge.nil? && !student.questions.nil? && !student.challenge.time_limit.blank?
		student.reset_challenge
		@list << "[#{student.email}]"
		end
	    end
	    if @list.blank?
	    redirect_to rhchallenge_administration_students_path, :notice => "Could not reset challenge of selected students as challenge does not exist or have already been resetted."
	    else
	    redirect_to rhchallenge_administration_students_path, :notice => "#{@list} challenge resetted!"
	    end
	end

	batch_action :generate_challenge_of, :confirm => "Are you sure you want to generate the challenge of selected students?" do |selection|
	    Student.find(selection).each do |student|
	      student.gen_questions
	      student.gen_challenge
	    end
	    redirect_to rhchallenge_administration_students_path, :notice => "#{@list} challenge generated!"
	end

	batch_action :clear_remember_created_at_of, :confirm => "Are you sure you want to clear remember status?" do |selection|
	    Student.find(selection).each do |student|
	      student.remember_created_at=nil
	      student.save
	    end
	    redirect_to rhchallenge_administration_students_path, :notice => "Remember status removed!"
	end

	batch_action :delete_challenge_of, :confirm => "Are you sure you want to delete challenge of selected students?" do |selection|
	    @completedlist=String.new
	    @notcompletedlist=String.new
		Student.find(selection).each do |student|
		if (!student.challenge.blank? && !student.questions.blank?)
		  student.cleanup
		  @completedlist << "[#{student.email}]"
		else
		  @notcompletedlist << "[#{student.email}]"
		end
	    end
	      @formatnotice=String.new
	      if !@completedlist.blank?
	      @formatnotice << "Challenge & Questions for #{@completedlist} have been deleted!"
	      end
	      @formatnotice << "<br/>"
	      if !@notcompletedlist.blank?
	      @formatnotice << "Challenge & Questions for #{@notcompletedlist} could not be deleted!"
	      end
	    redirect_to rhchallenge_administration_students_path, :notice => @formatnotice.html_safe
	end

	batch_action :activate_account_of, :confirm => "Are you sure you want to activate account of selected students?" do |selection|
	    @list=String.new
		Student.find(selection).each do |student|
		student.activate_student
		@list << "[#{student.email.to_s}]"
	    end
	    redirect_to rhchallenge_administration_students_path, :notice => "#{@list.to_s} activated successfully!"
	end

	member_action :toggle_trial, :method => :put do
		@student=Student.find(params[:id])
		@student.toggle_trial
		redirect_to rhchallenge_administration_student_path, :notice=> "Trial Has Been Set To #{@student.trial.to_s}"
	end

	action_item :only => [:show,:edit] do
		link_to 'Toggle Trial Status', toggle_trial_rhchallenge_administration_student_path(student), :method => :put, :confirm => "Are you sure you want toggle the trial status?"
	end

		index do
		selectable_column
		column :id
		column :first_name
		column :last_name
		column :email
		column :contact_number
		column :school
		column :country, :as=>:country_select
		column :language
		column :lecturer_name
		column :lecturer_email
		column ('Testing Mode'){|student| status_tag (student.trial ? "ENABLED" : "DISABLED"), (student.trial ? :ok : :error)unless student.trial.blank?}
	#	column :last_sign_in_ip Doesn't show anything useful since it is scaled
		column :challenge do |student|
			link_to "Challenge", :controller => "challenges", :action => "index", 'q[student_id_eq]' => "#{student.id}".html_safe
			end
		column :questions do |student|
	  		link_to "Questions", :controller => "questions", :action => "index", 'q[student_id_eq]' => "#{student.id}".html_safe
			end
		column 'Total Score', :sortable => 'challenges.total_score' do |student|
			student.challenge.total_score if !student.challenge.nil?
			end
		column 'Completed', :sortable => 'challenges.completed' do |student|
			status_tag (student.challenge.completed ? "COMPLETED" : "INCOMPLETE"), (student.challenge.completed ? :ok : :warning) if !student.challenge.nil?
			end
		column 'Timelimit', :sortable => 'challenges.time_limit' do |student|
			 student.challenge.time_limit.in_time_zone('Asia/Singapore').to_s unless student.challenge.nil? || student.challenge.time_limit.blank?
			end
		column :confirmation_token do |student|
			link_to "Confirm Account", student_confirmation_path(:confirmation_token=>student.confirmation_token),:data => {:confirm=>"Are you sure you want to confirm #{student.email.to_s} ?"} if(!student.confirmation_token.blank?)
		end
		column :reset_password_token do |student|
			link_to "Set Password", edit_password_path(student, :reset_password_token => student.reset_password_token),:data => {:confirm=>"Are you sure you want to edit password of #{student.email.to_s} ?"} if(!student.reset_password_token.blank?)
		end
		column :remember_created_at
		default_actions
		end

		form do |f|
		f.inputs "Student Details" do
		f.input :email
		f.input :first_name
		f.input :last_name
		f.input :contact_number
		f.input :country
		f.input :language
		f.input :lecturer_name
		f.input :lecturer_email
		f.input :school
		f.input :remember_created_at
		end
		f.buttons
		end
  end
end
