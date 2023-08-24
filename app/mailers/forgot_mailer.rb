class ForgotMailer < ApplicationMailer
    default from: "kian99564@gmail.com"

    def forgot_email(userEmail)
        mail(to: userEmail, subject: "Forgot Password")
    end
end
