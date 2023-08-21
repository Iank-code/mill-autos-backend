class Mpesa < ApplicationRecord
    # private

    # Generate Access Token Request -> Gives you a time bound access token to call allowed APIs in the sandbox
    def generate_access_token_request
        @url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
    
        @consumer_key = ENV['MPESA_CONSUMER_KEY']
        @consumer_secret = ENV['MPESA_CONSUMER_SECRET']
        @user_pass = Base64::strict_encode64("#{@consumer_key}:#{@consumer_secret}")
        headers = {
            Authorization: "Bearer #{@user_pass}"
        }
        res = RestClient::Request.execute(url: @url, method: :get, headers: {
            Authorization: "Basic #{@user_pass}"
        })
        
        res
    end

    def get_access_token
        res = generate_access_token_request()

        if res.code != 200
            r = generate_access_token_request()

            if res.code != 200
                raise MpessaError("Unable to generate access token")
            end
        end

        body = JSON.parse(res, {
            symbolize_names: true
        })
        token = body[:access_token]
        AccessToken.destroy_all()
        AccessToken.create!(token: token)
    end
end
