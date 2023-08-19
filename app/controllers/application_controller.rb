class ApplicationController < ActionController::API
    def app_response(message:"success", status: 200, data: nil)
        render json:{
            message: message,
            data: data,
        }, status: status
    end

    # Generating secret key
    def encode(uid, email)
        payload = {
            data:{
                uid: uid,
                email: email
            },
            exp: Time.now.to_i + (6 * 3600)
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
            token = auth_header.split(" ").first
            current_time = Time.now.to_i

            return current_time > token
        # rescue JWT::ExpiredSignature
        #     return true
        # rescue JWT::DecodeError, JWT::VerificationError
        #     return false
        end
    end
end
