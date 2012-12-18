class Questionzhcn < ActiveRecord::Base
  attr_accessible :answer, :choice1, :choice2, :choice3, :choice4, :difficulty, :question_text, :question_type, :topic
end
