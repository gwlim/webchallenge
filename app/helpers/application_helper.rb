module ApplicationHelper

	def homepageheader
		case (get_lang)
		when "zh-CN"
		Rails.cache.fetch('homepageheadercn'){ render :partial=> "layouts/zh-CN/homepageheader" }
		when "zh-TW"
		Rails.cache.fetch('homepageheadertw'){ render :partial=> "layouts/zh-TW/homepageheader" }
		else
		Rails.cache.fetch('homepageheaderen'){ render :partial=> "layouts/en-US/homepageheader" }
		end
	end

	def subpageheader
		case (get_lang)
		when "zh-CN"
		Rails.cache.fetch('subpageheadercn'){ render :partial=> "layouts/zh-CN/subpageheader" }
		when "zh-TW"
		Rails.cache.fetch('subpageheadertw'){ render :partial=> "layouts/zh-TW/subpageheader" }
		else
		Rails.cache.fetch('subpageheaderen'){ render :partial=> "layouts/en-US/subpageheader" }
		end
	end

	def footer
		case (get_lang)
		when "zh-CN"
		Rails.cache.fetch('footercn'){ render :partial=> "layouts/zh-CN/footer" }
		when "zh-TW"
		Rails.cache.fetch('footertw'){ render :partial=> "layouts/zh-TW/footer" }
		else
		Rails.cache.fetch('footeren'){ render :partial=> "layouts/en-US/footer" }
		end
	end

	def add_recaptcha_tag
	  recaptcha_tags(:ssl=>true,:ajax=>true,:display=>{:theme=>"clean"}) if (Appconfig.first.enable_recaptcha==true)
	end

	def get_lang
	    if student_signed_in?
	      return current_student.language
	    else
	      return params[:locale]
	    end
	end
end

