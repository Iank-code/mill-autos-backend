class CustomersController < ApplicationController
    require 'securerandom'
    # Registering
    def register
        user = Customer.create(user_params)
        if user.valid?
            # Send email if user is created successfully
            UserMailer.with(user: user).welcome_email(user.email).deliver_now

            user_attributes = user.attributes.except("updated_at", "created_at", "password_digest")

            app_response(message: "User created successfully", status: :created, data: {user: user_attributes})
        end
    end

    # Loggin in
    def login
        sql = "username = :username"

        user = Customer.where(sql, { username: user_params[:username], email: user_params[:email] }).first

        if user.authenticate(user_params[:password])
            token = encode(user.id, user.email)
            user_attributes = user.attributes.except("updated_at", "created_at", "password_digest")

            image = get_image(user.id)

            app_response(message: "Login was successful", status: 200, data: {token: token, user: user_attributes, image: image})

        else
            app_response(message: "Authentication failed", status:400)
        end
    end

    # Forgot Password
    def forgot_password_step_1
        sql = "email = :email"
        user = Customer.where(sql, { email: user_params[:email] }).first
        if user
            # Generating Reset Token
            random_string = SecureRandom.hex(3)
            user.password_reset_token = random_string
            user.save

            # Send email if user is found
            ForgotMailer.with(user: user.email, token: random_string).forgot_email(user.email, random_string).deliver_now

            app_response(message: "An email has been sent successfully", status: 200)
        end
    end

    # testing jwt code
    def test_token
        verify_auth
    end


    # Private methods
    private
    def user_params
        params.permit(:username, :email, :password, :password_confirmation, :phone_number, :file)
    end
end
