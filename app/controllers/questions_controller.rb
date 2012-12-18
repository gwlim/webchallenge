class QuestionsController < ApplicationController
before_filter :authenticate_student!,:check_complete
before_filter :check_challenge_open,:only=>[:index]

  def check_challenge_open
	if current_student.challenge_start==false || current_student.challenge.nil? || current_student.questions.first.nil?
	redirect_to(student_root_path) 
	end
  end

  def index
	#check_challenge_open
	current_student.starttime
	@question = current_student.get_currentquestion
	@displayquestion=current_student.get_displayquestion(@question.question_no)
	@timeleft=current_student.challenge.time_limit-Time.now
	    respond_to do |format|
	      format.js 
	      format.html # show.html.erb
#	      format.json { render :json => @question }
	    end
  end
  # PUT /questions/1
  # PUT /questions/1.json
  def update
    params[:question].blank? ? ( @answer=params[:answer].join(",") unless params[:answer].nil? ) : @answer=params[:question][:answer]
    current_student.mark_routine(@answer)
    respond_to do |format|
	@timeleft=current_student.challenge.time_limit-Time.now
	@question = current_student.get_currentquestion
	@displayquestion=current_student.get_displayquestion(@question.question_no)
	format.js 
	format.html { render :action =>"index" }
#	format.json { render :json => @question.errors, :status => :unprocessable_entity }
#      else
#	format.js { render :text => "Error Saving Question"}
#        format.html { render :action => "edit" }
##       format.json { render :json => @question.errors, :status => :unprocessable_entity }
#      end
    end
  end

	def check_complete
		if current_student.challenge.completed==true
			params[:question].blank? ? ( @answer=params[:answer].join(",") unless params[:answer].nil? ) : @answer=params[:question][:answer]
			current_student.mark_routine( @answer)
		respond_to do |format|	
			format.js   {  render :js => "window.location.replace('#{student_result_path}');" and return }
		        format.html { redirect_to student_root_path }
#		        format.json { render :json => @question.errors, :status => :unprocessable_entity }
		end
	    end	
	end
	

end
