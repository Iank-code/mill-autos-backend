class ApplicationController < ActionController::API
    require 'jwt'

    # This method is used to return the response of a request
    def app_response(message:"success", status: 200, data: nil)
        render json:{
            message: message,
            data: data,
        }, status: status
    end

    # Getting the image from active storage
    def get_image(uid)
        blob = ActiveStorage::Blob.find(uid)
        image = url_for(blob)

        return image
    end

    # Searching if customer user exists
    def if_customer_exists
        sql = "email = :email"
        user = Customer.where(sql, { email: user_params[:email] }).first

        return user
    end

    # Searching for a customer using password reset token
    def if_customer_exists_by_password_reset
        sql = "password_reset_token = :password_reset_token"
        user = Customer.where(sql, { password_reset_token: user_params[:password_reset_token] }).first

        return user
    end

    # Generating secret key
    def encode(uid, email)
        payload = {
            data:{
                uid: uid,
                email: email
            },
            exp: Time.now.to_i + (2 * 60)
        }

        JWT.encode(payload, ENV["JWT_PASS"], "HS256")

    end

    # Decoding the hashed payload
    def decode(token)
        JWT.decode(token, ENV["JWT_PASS"], "HS256")
    end

    # Verify the authorization header
    def verify_auth
        auth_header = request.headers["Authorization"]

        if !auth_header
            app_response(message: "Failed", status: 401, data: {
                info: "Your request was not authorized"
            })
        else
            token = auth_header.split(" ")
            jwt_token = token[1]
            
            decode_token = decode(jwt_token)
            current_time = Time.now.to_i
            app_response(message: "JWT found", data: decode_token)
        end
    end
end
