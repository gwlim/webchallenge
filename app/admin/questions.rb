ActiveAdmin.register Question do
if Question.table_exists?
  config.sort_order = "id_asc"
  config.per_page = 100
  menu :parent => "Student Information",:priority=>3
	filter :id
	filter :student_email, :as=>:select, :collection => Student.all.map(&:email)
	filter :student_email, :as=>:string
	filter :student_id, :as => :select, :collection => Student.all.map(&:id), :label => 'Student ID Number'
	filter :question_idx , :label => 'Question Index Number'
	filter :score
	filter :answer
	filter :question_no

  end
end
