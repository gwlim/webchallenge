ActiveAdmin.register_page "Winners" do 
  content :title => proc{ ("RedHat Challenge Winners") } do
    columns do
    column do
          panel "CHINA WINNERS" do
	     table_for Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"China"},:order=>'challenges.total_score DESC',:limit=>20) do
	       column("Name") { |student| "#{student.first_name} #{student.last_name}" }
	       column("Email") { |student| "#{student.email}" }
	       column("School") { |student| "#{student.school}" }
	       column("Contact No.") { |student| "#{student.contact_number}" }
	       column("Score") { |student| "#{student.challenge.total_score}" }
	     end
	    end
	    panel "HONG KONG WINNERS" do
	     table_for Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Hong Kong"},:order=>'challenges.total_score DESC',:limit=>20) do
	       column("Name") { |student| "#{student.first_name} #{student.last_name}" }
	       column("Email") { |student| "#{student.email}" }
	       column("School") { |student| "#{student.school}" }
	       column("Contact No.") { |student| "#{student.contact_number}" }
	       column("Score") { |student| "#{student.challenge.total_score}" }
	     end
	    end
	    panel "TAIWAN WINNERS" do
	     table_for Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Taiwan"},:order=>'challenges.total_score DESC',:limit=>20) do
	       column("Name") { |student| "#{student.first_name} #{student.last_name}" }
	       column("Email") { |student| "#{student.email}" }
	       column("School") { |student| "#{student.school}" }
	       column("Contact No.") { |student| "#{student.contact_number}" }
	       column("Score") { |student| "#{student.challenge.total_score}" }
	     end
	    end
    end
    column do
      	    panel "SINGAPORE WINNERS" do
	     table_for Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Singapore"},:order=>'challenges.total_score DESC',:limit=>20) do
	       column("Name") { |student| "#{student.first_name} #{student.last_name}" }
	       column("Email") { |student| "#{student.email}" }
	       column("School") { |student| "#{student.school}" }
	       column("Contact No.") { |student| "#{student.contact_number}" }
	       column("Score") { |student| "#{student.challenge.total_score}" }
	     end
	    end
	    panel "MALAYSIA WINNERS" do
	     table_for Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Malaysia"},:order=>'challenges.total_score DESC',:limit=>20) do
	       column("Name") { |student| "#{student.first_name} #{student.last_name}" }
	       column("Email") { |student| "#{student.email}" }
	       column("School") { |student| "#{student.school}" }
	       column("Contact No.") { |student| "#{student.contact_number}" }
	       column("Score") { |student| "#{student.challenge.total_score}" }
	     end
	    end
    end
    end
  end
end