class Customer < ApplicationRecord
    has_secure_password
    has_one_attached :file

    validates :email, {
        presence: true,
        uniqueness: true
    }

    validates :password_reset_token,{
        uniqueness: true,
        allow_nil: true
    }
end
