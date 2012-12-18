class Question < ActiveRecord::Base
	belongs_to :student

attr_accessible :question_idx, :student_id, :question_no, :answer, :score


end
