class StudentMailer < Devise::Mailer
  def headers_for(action)
    I18n.locale=@resource.language if !(@resource.language.blank?)
    email_with_name = "#{resource.first_name} #{resource.last_name} <#{resource.email}>"
    headers = {
      :subject       => translate(devise_mapping, action),
      :from          => mailer_sender(devise_mapping),
      :to            => email_with_name,
      :template_path => template_paths
    }
  end
end
