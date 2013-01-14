class Challenge < ActiveRecord::Base
	belongs_to :student
attr_accessible :student_id, :total_questions, :total_score, :completed, :time_limit, :last_attempted_question, :last_question  

	def check_if_end
		if self.time_limit<Time.now || self.last_attempted_question>=self.last_question
				self.completed = true
				self.save
		end
	end

end
