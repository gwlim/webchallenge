ActiveAdmin.register_page "Dashboard" do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  menu :parent => "Application",:priority => 2
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    citytz=['America/New_York', 'Etc/UTC', 'Asia/Bangkok', 'Asia/Hong_Kong', 'Asia/Singapore', 'Asia/Kuala_Lumpur','Asia/Taipei','Asia/Manila']
    cityctz=['Asia/Shanghai']
    rs=Appconfig.find_by_id(1).registration_start
    re=Appconfig.find_by_id(1).registration_end
    cs=Rhconfig.find_by_id(1).challenge_start
    ce=Rhconfig.find_by_id(1).challenge_end
    ccs=Rhconfig.find_by_id(2).challenge_start
    cce=Rhconfig.find_by_id(2).challenge_end
    columns do
	column do
	      panel "Challenge Status" do
			table do
				  th "Challenge Mode"
				  th "Status"
				  tr
				  td "Automatic Registration"
				  td {status_tag (Appconfig.find_by_id(1).registration_override ? "OFF" : "ON"),(Appconfig.find_by_id(1).registration_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For Other Countries"
				  td {status_tag (Rhconfig.find_by_id(1).challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_id(1).challenge_override ? :error : :ok)}
				  tr
				  td "Automatic Challenge For China"
				  td {status_tag (Rhconfig.find_by_id(2).challenge_override ? "OFF" : "ON"),(Rhconfig.find_by_id(2).challenge_override ? :error : :ok)}

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
				  for @cct in cityctz do
				  tr
				  td "#{@cct.to_s}"
				  td "#{DateTime.now.in_time_zone(@cct.to_s).to_s}"
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
		      td "Challenge Start"
		      td "#{cs.in_time_zone(ct).to_s}"
		      tr
		      td "Challenge Close"
		      td "#{ce.in_time_zone(ct).to_s}"
		    end
		end
	    end
	    for cct in cityctz do
		panel "#{cct}" do
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
		      td "Challenge Start"
		      td "#{ccs.in_time_zone(ct).to_s}"
		      tr
		      td "Challenge Close"
		      td "#{cce.in_time_zone(ct).to_s}"
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
