class UserMailer < ApplicationMailer
    default from: "kian99564@gmail.com"

    def welcome_email(userEmail)
        mail(to: userEmail, subject: "Welcome To Mill Autos")
    end
end
