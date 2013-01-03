ActiveAdmin.register_page "Statistics" do
  content :title => proc{ ("RedHat Challenge Statistics") } do
    columns do
    column do
	  panel "Total Participants" do
	    div do
	      "China: " "#{Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"China"}).count}"
	    end
	    div do
	      "Hong Kong: " "#{Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Hong Kong"}).count}"
	    end
	    div do
	      "Singapore: " "#{Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Singapore"}).count}"
	    end
	    div do
	      "Malaysia: " "#{Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Malaysia"}).count}"
	    end
	    div do
	      "Taiwan: " "#{Student.find(:all,:joins=>:challenge,:conditions=>{:challenges=>{:completed=>true},:country=>"Taiwan"}).count}"
	    end

	  end
          panel "Charts" do
	    render 'charts/chart'
	    end

    end
    end
  end
end
