class Rhconfig < ActiveRecord::Base
 attr_accessible :country, :add_diff_qn, :add_easy_qn, :add_norm_qn, :qn_per_topic, :total_qn,
:challenge_end, :challenge_override, :challenge_start,:challenge_on,
:time_limit
end
