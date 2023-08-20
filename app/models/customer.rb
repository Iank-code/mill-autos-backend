class Customer < ApplicationRecord
    has_secure_password
    has_one_attached :file

    validates :email, {
        presence: true,
        uniqueness: true
    }
end
