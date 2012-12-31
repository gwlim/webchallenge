ActiveAdmin.register Questionen, :as => "English Question" do
if Questionen.table_exists?
  config.sort_order = "id_asc"
   config.per_page = 100
   menu :parent => "Question Database"
	filter :id
	filter :topic
	filter :difficulty
		actions :all, :except => [:destroy]
  end
end
