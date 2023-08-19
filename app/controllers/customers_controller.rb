class CustomersController < ApplicationController
    # Registering
    def register
        user = Customer.create(user_params)
        if user.valid?
            user_attributes = user.attributes.except("updated_at", "created_at", "password_digest")

            app_response(message: "User created successfully", status: :created, data: {user: user})
        end
    end

    # Private methods
    private
    def user_params
        params.permit(:username, :email, :password, :password_confirmation, :phone_number)
    end
end
