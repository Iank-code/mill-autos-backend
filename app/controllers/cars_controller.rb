class CarsController < ApplicationController
    # Posting the car(s)
    def new_car
        car = Car.create(car_params)
        # if car.valid?
            # Send email if user is created successfully
            # UserMailer.with(user: user).welcome_email(user.email).deliver_now

        # end
        car_attributes = car.attributes.except("updated_at", "created_at")

        app_response(message: "Car uploaded successfully", status: :created, data: {car: car_attributes})
    end


    private
    def car_params
        params.permit(:model, :brand, :price, :year_of_manufacture, :file)
    end
end
