ActiveAdmin.register Questionzhcn, :as => "Simplified Chinese Question" do
if Questionzhcn.table_exists?
    config.per_page = 100
    config.sort_order = "id_asc"
  menu :parent => "Question Database"
filter :id
filter :topic
filter :difficulty

	actions :all, :except => [:destroy]
 end
end
