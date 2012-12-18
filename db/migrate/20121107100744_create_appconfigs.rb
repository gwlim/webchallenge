class CreateAppconfigs < ActiveRecord::Migration
  def change
    create_table :appconfigs do |t|
      t.boolean :enable_recaptcha
      t.string :default_password
      t.date :registration_start
      t.date :registration_end
      t.boolean :registration_override
      t.boolean :registration_on
      t.timestamps
    end
    Appconfig.create!(:enable_recaptcha=>true,:default_password=>"password",:registration_on=>true,:registration_override=>true)
  end
end
