class Student < ActiveRecord::Base
	has_many :questions
	has_one :challenge
	scope :activated, where(:confirmation_token=>nil)
	scope :inactivated, where(:confirmed_at=>nil)
	after_destroy :cleanup

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
	 :confirmable, :timeoutable#, :rememberable,:trackable
  attr_protected :trial
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,:first_name, :last_name,
		  :contact_number, :school,:language, :country, :lecturer_name, :lecturer_email, :terms

  validates :first_name, :presence => true, :length => { :maximum => 100 }
  validates :last_name, :presence => true, :length => { :maximum => 100 }
  validates :contact_number, :presence => true, :uniqueness => true
  validates :country, :presence => true
  validates :school, :presence => true
  validates :language, :presence => true
  validates_acceptance_of :terms, :on => :create

      	def toggle_trial
		self.trial=!self.trial
		self.save
	end

	def get_currentquestion_no
		return self.questions.find_by_question_idx(self.challenge.last_attempted_question).question_no
	end

	def get_currentquestion
		return self.questions.find_by_question_idx(self.challenge.last_attempted_question)
	end

	def cleanup
	      self.questions.destroy_all unless (self.questions.blank?)
	      self.challenge.destroy unless (self.challenge.blank?)
	end

	def challenge_start
		if (self.trial==true)
			return true
		elsif (Rhconfig.find_by_country(self.country).challenge_override==true) && (Rhconfig.find_by_country(self.country).challenge_on==true)
			return true
		elsif (Rhconfig.find_by_country(self.country).challenge_override==true) && (Rhconfig.find_by_country(self.country).challenge_on==false)
			return false
		elsif (Time.now > Rhconfig.find_by_country(self.country).challenge_start && Time.now < Rhconfig.find_by_country(self.country).challenge_end)
			return true
		else
			return false
		end
	end

	def timeleft
		return self.challenge.time_limit-Time.now
	end

	def student_grade
	      @totalmarks=Array.new
	      @totalmarks=self.questions.pluck(:score)
	      #assign it to total_score, save and redirect to student result page
	      #save it to challenge attribute
	      self.challenge.total_score=@totalmarks.sum
	      self.challenge.save
	end
	#If time is not started start it now
	def starttime
		if self.challenge.time_limit.blank?
		  if(Time.now+Rhconfig.find_by_country(self.country).time_limit.minutes<=Rhconfig.find_by_country(self.country).challenge_end) # if Time now + Test Duration is less than Test End Time
			  self.challenge.time_limit=Time.now+Rhconfig.find_by_country(self.country).time_limit.minutes
			else
			  self.challenge.time_limit=Rhconfig.find_by_country(self.country).challenge_end # if Time overshot student is only given remaining time to complete the test
			end
			self.challenge.save
		end
	end

	def get_displayquestion(last_attempted_question)

		case self.language.to_s
		when "zh-CN"
			return Questionzhcn.find(last_attempted_question)
		when "zh-TW"
			return Questionzhtw.find(last_attempted_question)
		else
			return Questionen.find(last_attempted_question)
		end
	end

	def mark_routine(s_answer)
		@question = self.get_currentquestion
		@displayquestion=self.get_displayquestion(@question.question_no)
		transaction do
		  if s_answer.to_s==@displayquestion.answer.to_s
			  @question.score=1
			  self.challenge.increment(:total_score)
		  else
			  @question.score=0
		  end
		  @question.answer=s_answer
		  @question.save
		  self.challenge.increment(:last_attempted_question)
		  self.challenge.check_if_end
		  self.challenge.save
		end
	end

	#Overide the after confirmation action
	def confirm!
		super
		#if questions are not created create it
		if self.questions.first.nil?
			self.gen_questions
			self.save
		end
		#if challenge is not created, create it
		if self.challenge.nil?
		  self.build_challenge(:total_questions=>Rhconfig.find_by_country(self.country).total_qn,:last_attempted_question=>self.questions.first.question_idx,:total_score=>0,:completed=>false,:last_question=>self.questions.last.question_idx)
		      	self.save
		end
	end

	def local_confirm
	    	if self.questions.first.nil?
			self.gen_questions
			self.save
		end
		#if challenge is not created, create it
		if self.challenge.nil?
			self.build_challenge(:total_questions=>Rhconfig.find_by_country(self.country).total_qn,:last_attempted_question=>self.questions.first.question_idx,:total_score=>0,:completed=>false,:last_question=>self.questions.last.question_idx)
		      	self.save
		end
	end

	#Generate the array, create the questions and save it
	#Have to call the array generator inside the function else will fail
	def gen_questions
		if self.questions.first.nil?
		  transaction do
		    @array=self.gen_ran_array(:total_qn=>Rhconfig.find_by_country(self.country).total_qn,:num_qn_topic=>Rhconfig.find_by_country(self.country).qn_per_topic,:diff_qn=>Rhconfig.find_by_country(self.country).add_diff_qn,:norm_qn=>Rhconfig.find_by_country(self.country).add_norm_qn,:easy_qn=>Rhconfig.find_by_country(self.country).add_easy_qn)
		    @array.each_with_index do |i,index|
			    self.questions.build(:question_idx => index+1, :question_no=>i,:answer=>"",:score=>0)
			    end
		    self.save
		  end
		end
	end

	def gen_challenge
		if self.challenge.nil?
		  transaction do
		    self.build_challenge(:total_questions=>Rhconfig.find_by_country(self.country).total_qn,:last_attempted_question=>self.questions.first.question_idx,:total_score=>0,:completed=>false,:last_question=>self.questions.last.question_idx)
		    self.save
		end
	  end
	end

	def reset_challenge
		if !self.challenge.time_limit.blank?
		    transaction do
		  self.challenge.update_attributes(:last_attempted_question=>1,:completed=>false,:total_score=>0,:time_limit=>nil)
		  self.questions.update_all(:score=>0,:answer=>"")
		  end
		end
	end

	def reset_password
		@new_password=(Appconfig.find_by_id(1).default_password)
		transaction do
		self.password = @new_password
		self.skip_confirmation!
		self.confirmation_token=nil
		self.save
		end
	end

	def activate_student
		self.skip_confirmation!
		self.confirmation_token=nil
		self.save
	end

	#Give this function a number hash and it will return you an array of questions
	#If the number of special parameters of qn exceed total_qn required it will return false
	def gen_ran_array(param={})
	@countarray=Questionen.uniq.pluck(:topic)
	@num_qn_topic=param[:num_qn_topic] || 1
	@diff_qn = param[:diff_qn]
	@norm_qn = param[:norm_qn]
	@easy_qn = param[:easy_qn]
	@total_qn = param[:total_qn]
	@mainarray=Array.new
	@suparray=Array.new
		@countarray.each do |x|
		@mainarray.concat(Questionen.where(:topic=>x).pluck(:id).sample(@num_qn_topic))
		end
			if !@diff_qn.nil?
				@diffqn=Array.new
				@diffqn=Questionen.where(:difficulty=>"3").pluck(:id)
				@suparray=@diffqn-@mainarray
				if @suparray.size.to_i > @diff_qn
					@mainarray.concat(@suparray.sample(@diff_qn))
				else
					@mainarray.concat(@suparray)
					@norm_qn=@diff_qn-@suparray.size
				end
			end
			if !@norm_qn.nil?
				@normqn=Array.new
				@normqn=Questionen.where(:difficulty=>"2").pluck(:id)
				@suparray=@normqn-@mainarray
				if @suparray.size.to_i > @norm_qn
					@mainarray.concat(@suparray.sample(@norm_qn))
				else
					@mainarray.concat(@suparray)
					@easy_qn=@diff_qn-@suparray.size
				end
			end
			if !@easy_qn.nil?
				@easyqn=Array.new
				@easyqn=Questionen.where(:difficulty=>"1").pluck(:id)
				@suparray=@easyqn-@mainarray
				if @suparray.size.to_i > @easy_qn
					@mainarray.concat(@suparray.sample(@easy_qn))
				else
					@mainarray.concat(@suparray)
				end
			end
			if !@total_qn.nil?
				@allqn=Array.new
				@allqn=Questionen.pluck(:id)
				@suparray=@allqn-@mainarray
				if @total_qn >= @mainarray.size && !@suparray.blank?
					@remain=Array.new
					@remain=@total_qn-@mainarray.size
					@mainarray.concat(@suparray.sample(@remain))
				else
					return false
				end
			end
	return @mainarray.shuffle
	end
end
