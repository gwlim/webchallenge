class Questionen < ActiveRecord::Base
  attr_accessible :question_type,:topic,:difficulty,:question_text,:choice1,:choice2,:choice3,:choice4,:answer
end
