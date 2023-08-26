class CarsController < ApplicationController
    # Posting the car(s)
    def new_car
        car = Car.create(car_params)
        car_attributes = car.attributes.except("updated_at", "created_at")

        app_response(message: "Car uploaded successfully", status: :created, data: {car: car_attributes})
    end

    def index
        @car = Car.all

        images = []
        @car.each do | car |
            img = get_image(car.id)

            car_data = car.attributes.merge(pics: img)
            images << car_data
        end
        app_response(data: images, status: 200)
    end


    private
    def car_params
        params.permit(:model, :brand, :price, :year_of_manufacture, files: [])
    end
end
