ActiveAdmin.register Challenge do
if Challenge.table_exists?
  config.sort_order = "id_asc"
  menu :parent => "Student Information",:priority => 2
	filter :student_email, :as=>:select, :collection => Student.all.map(&:email)
	filter :student_email, :as=>:string
	filter :student_id, :as => :select, :collection => Student.all.map(&:id) , :label => 'Student ID Number'
	filter :time_limit
	filter :total_score
	filter :completed, :as => :select 
  end  
end
