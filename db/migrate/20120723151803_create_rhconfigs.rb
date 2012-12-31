class CreateRhconfigs < ActiveRecord::Migration
  def change
    create_table :rhconfigs do |t|
      t.string	:country
      t.integer :total_qn
      t.integer :qn_per_topic
      t.integer :add_diff_qn
      t.integer :add_norm_qn
      t.integer :add_easy_qn
      t.integer :time_limit
      t.datetime :challenge_start
      t.datetime :challenge_end
      t.boolean :challenge_on
      t.boolean :challenge_override

      t.timestamps
    end
Rhconfig.create!([{:country=>"China", :challenge_start=>DateTime.new(2012,01,12,23,59), :challenge_end=>DateTime.new(2013,01,12,23,59), :challenge_override=>false, :qn_per_topic=>1, :time_limit=>60, :total_qn=>20, :add_diff_qn=>nil, :add_easy_qn=>nil, :add_norm_qn=>nil}])
Rhconfig.create!([{:country=>"Hong Kong",:challenge_start=>DateTime.new(2012,01,12,23,59), :challenge_end=>DateTime.new(2013,01,12,23,59), :challenge_override=>false, :qn_per_topic=>1, :time_limit=>60, :total_qn=>20, :add_diff_qn=>nil, :add_easy_qn=>nil, :add_norm_qn=>nil}])
Rhconfig.create!([{:country=>"Malaysia",:challenge_start=>DateTime.new(2012,01,12,23,59), :challenge_end=>DateTime.new(2013,01,12,23,59), :challenge_override=>false, :qn_per_topic=>1, :time_limit=>60, :total_qn=>20, :add_diff_qn=>nil, :add_easy_qn=>nil, :add_norm_qn=>nil}])
Rhconfig.create!([{:country=>"Singapore", :challenge_start=>DateTime.new(2012,01,12,23,59), :challenge_end=>DateTime.new(2013,01,12,23,59), :challenge_override=>false, :qn_per_topic=>1, :time_limit=>60, :total_qn=>20, :add_diff_qn=>nil, :add_easy_qn=>nil, :add_norm_qn=>nil}])
Rhconfig.create!([{:country=>"Taiwan", :challenge_start=>DateTime.new(2012,01,12,23,59), :challenge_end=>DateTime.new(2013,01,12,23,59), :challenge_override=>false, :qn_per_topic=>1, :time_limit=>60, :total_qn=>20, :add_diff_qn=>nil, :add_easy_qn=>nil, :add_norm_qn=>nil}])
add_index :rhconfigs, :country,                :unique => true
add_index :rhconfigs, :qn_per_topic,                :unique => false
add_index :rhconfigs, :add_diff_qn,                :unique => false
add_index :rhconfigs, :add_norm_qn,                :unique => false
add_index :rhconfigs, :add_easy_qn,                :unique => false
add_index :rhconfigs, :time_limit,                :unique => false
add_index :rhconfigs, :challenge_start,                :unique => false
add_index :rhconfigs, :challenge_end,                :unique => false
add_index :rhconfigs, :challenge_on,                :unique => false
add_index :rhconfigs, :challenge_override,                :unique => false

  end

end
