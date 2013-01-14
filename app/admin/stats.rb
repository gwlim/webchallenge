ActiveAdmin.register_page "Statistics" do
  content :title => proc{ ("RedHat Challenge Statistics") } do
    columns do
    column do
	  panel "Total Participants" do
	    render 'charts/bar'
	  end
          panel "Charts" do
	    render 'charts/chart'
	    end

    end
    end
  end
end
