ActiveAdmin.register Questionzhtw , :as => "Traditional Chinese Question" do
if Questionzhtw.table_exists?
    config.per_page = 100
    config.sort_order = "id_asc"
  menu :parent => "Question Database"
filter :id
filter :topic
filter :difficulty

	actions :all, :except => [:destroy]
end
end
