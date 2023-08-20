class Customer < ApplicationRecord
    has_secure_password
    has_one_attached :file

    # validates :phone_number{
    #     presence: true,
    #     uniqueness: true
    # }
    validates :email, {
        presence: true,
        uniqueness: true
    }
end
