Rails.application.config.action_mailer.smtp_settings = {
	address:              'smtp.gmail.com',
	port:                 587,
	domain:               'gmail.com',
	user_name:            ENV["GMAIL_USER"],
	password:             ENV["GMAIL_PASS"],
	authentication:       'plain',
	enable_starttls_auto: true  }
	
Rails.application.config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }