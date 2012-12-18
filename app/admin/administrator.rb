ActiveAdmin.register Administrator do
  config.sort_order = "id_asc"
	collection_action :create_test_account, :method => :put do
	  Rhconfig.first.update_attribute(:registration_on,false)
	  Rhconfig.first.update_attribute(:registration_override,true)
		(0..1500).each do |i|
		  if !(Student.find_by_email("redhattest#{i.to_s}@redhat.com"))
		    @email="redhattest#{i.to_s}@redhat.com"
		    @password="password"
		    @c_no=(i*10).to_i
		    #@lang=["en-US","zh-CN","zh-TW"].sample
		    @account=Student.new
		    @account.id=Student.last.id+1
		    @account.email=@email
		    @account.password=@password
		    @account.password_confirmation=@password
		    @account.contact_number=@c_no
		    @account.first_name="Test"
		    @account.last_name="Account#{i.to_s}"
		    @account.school="Test Account Academy"
		    @account.language="en-US"
		    @account.country="Singapore"
		    @account.save
		    @account.toggle_lock
		    @account.activate_student
		    @account.local_confirm
		  end
		end
		redirect_to rhchallenge_administration_students_path, :notice=> "Test Accounts Created"
	end
	
	collection_action :delete_test_account, :method => :put do
		  Rhconfig.first.update_attribute(:registration_on,false)
		  Rhconfig.first.update_attribute(:registration_override,true)
		(0..1500).each do |i|
		  if (Student.find_by_email("redhattest#{i.to_s}@redhat.com"))  
		  @account=Student.find_by_email("redhattest#{i.to_s}@redhat.com").destroy
		  end
		end
		redirect_to rhchallenge_administration_students_path, :notice=> "Test Accounts Deleted"
	end
	
	collection_action :reset_test_account, :method => :put do
	   Student.where(:school => "Test Account Academy").find_each do |student|
		student.reset_challenge
		end
		redirect_to rhchallenge_administration_students_path, :notice=> "Test Accounts Resetted"
	end
		                       
	action_item :only => [:index] do
		link_to 'Create Test Accounts', create_test_account_rhchallenge_administration_administrators_path, :method => :put, :confirm => "Are you sure you want to create 1500 Test Accounts?\nRegistration will be closed.\nThis will take a while..." 
	end
	
	action_item :only => [:index] do
		link_to 'Delete Test Accounts', delete_test_account_rhchallenge_administration_administrators_path, :method => :put, :confirm => "Are you sure you want to delete 1500 Test Accounts?\nRegistration will be closed.\nThis will take a while..." 
	end
	
	action_item :only => [:index] do
		link_to 'Reset Test Accounts', reset_test_account_rhchallenge_administration_administrators_path, :method => :put, :confirm => "Are you sure you want to reset 1500 Test Accounts?\nThis will take a while..." 
	end
	
	index do
	  selectable_column
	  column :id
	  column :email
	  column :reset_password_token
	  column :current_sign_in_at
	  column :last_sign_in_at
	  column :updated_at
	end
	
	form do |f|
		f.inputs "Administrator Details" do
		f.input :email
		f.input :password
		f.input :password_confirmation
		end
		f.buttons
	end

end
