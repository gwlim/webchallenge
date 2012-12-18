class StudentsController < ApplicationController
before_filter :authenticate_student!
before_filter :check_complete_challenge,:only=>[:result]
	def home
	    respond_to do |format|
	      format.js
	      format.html # show.html.erb
#	      format.json { render :json => @question }
	  end
	end

	def result
	    check_complete_challenge
	    respond_to do |format|
	      format.js
	      format.html # show.html.erb
#	      format.json { render :json => @question }
	    end
	end

	def check_complete_challenge
	    if !current_student.challenge.completed?
			redirect_to(student_root_path) and return
	    elsif current_student.challenge.total_score.blank?
			current_student.student_grade
	    end
	end
end
