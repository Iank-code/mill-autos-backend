class ForgotMailer < ApplicationMailer
    default from: "kian99564@gmail.com"

    def forgot_email(userEmail, random_string)
        @reset_key = random_string
        mail(to: userEmail, subject: "Forgot Password")
    end
end
