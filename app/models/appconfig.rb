class Appconfig < ActiveRecord::Base
  attr_accessible :default_password, :enable_recaptcha, :registration_start,:registration_end,:registration_override,:registration_on
  def registration_open
    if (self.registration_override==true) && (self.registration_on==true)
      return true
    elsif (self.registration_override==true) && (self.registration_on==false)
      return false
    elsif (Time.now > self.registration_start && Time.now < self.registration_end )
      return true
    else
      return false
    end
  end
end
