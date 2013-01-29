ActiveAdmin.register_page "Dashboard" do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  menu :parent => "Application",:priority => 2
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    citytz=['America/New_York', 'Etc/UTC', 'Asia/Shanghai', 'Asia/Hong_Kong', 'Asia/Singapore', 'Asia/Kuala_Lumpur','Asia/Taipei',]
    countrylist=["China","Hong Kong","Singapore","Malaysia","Taiwan"]
    rs=Appconfig.find_by_id(1).registration_start
    re=Appconfig.find_by_id(1).registration_end
    columns do
      
	column do
	  	
	  panel "Host" do
	    table do
	    Host::LoadAverage.refresh
	    Host::Memory.refresh
	      th "Load Average"
	      th "Memory(MB)"
	      th "Processor"
	      tr
	      td Host::LoadAverage.on_last(1).to_s
	      td (Host::Memory.total/1024).to_s
	      td Host::Processor.core(1).model_name
	      tr
	      td Host::LoadAverage.on_last(5).to_s
	      td (Host::Memory.free/1024).to_s
	      td Host::Processor.cores.to_s+" Core(s)"
	      tr
	      td Host::LoadAverage.on_last(15).to_s
	    end

	  end
	
	      panel "Challenge Status" do
			table do
				  th "Challenge Mode"
				  th "Status"
				  tr
				  td "Automatic Registration"
				  td {status_tag (Appconfig.find_by_id(1).registration_override ? "OFF" : "ON"),(Appconfig.find_by_id(1).registration_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For China"
				  td {status_tag (Rhconfig.find_by_country("China").challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_country("China").challenge_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For Hong Kong"
				  td {status_tag (Rhconfig.find_by_country("Hong Kong").challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_country("Hong Kong").challenge_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For Malaysia"
				  td {status_tag (Rhconfig.find_by_country("Malaysia").challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_country("Malaysia").challenge_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For Singapore"
				  td {status_tag (Rhconfig.find_by_country("Singapore").challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_country("Singapore").challenge_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For Taiwan"
				  td {status_tag (Rhconfig.find_by_country("Taiwan").challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_country("Taiwan").challenge_override ? :error : :ok)}

			end
	      end
	      panel "Time Zones" do
			table do
				th "TimeZone"
				th "Time"
				for @ct in citytz do
				  tr
				  td "#{@ct.to_s}"
				  td "#{DateTime.now.in_time_zone(@ct.to_s).to_s}"
			end

		    end
	      end
	end
	column do
	    for ct in citytz do
		panel "#{ct}" do
		    table do
		      th "Information"
		      th "Date Time"
		      tr
		      td "Registration Start"
		      td "#{rs.to_s}"
		      tr
		      td "Registration Close"
		      td "#{re.to_s}"
		      tr
			for @cl in countrylist do
			td "#{@cl} Challenge Start"
			td "#{Rhconfig.find_by_country(@cl).challenge_start.in_time_zone(ct.to_s).to_s}"
			tr
			td "#{@cl} Challenge Close"
			td "#{Rhconfig.find_by_country(@cl).challenge_end.in_time_zone(ct.to_s).to_s}"
			tr
			end
		    end
		end
	    end
	end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }
    end
  end
end
