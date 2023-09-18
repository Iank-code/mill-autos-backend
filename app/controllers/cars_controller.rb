class CarsController < ApplicationController
    # Posting the car(s)
    def new_car
        @car = Car.create(car_params)
        car_attributes = @car.attributes.except("updated_at", "created_at")

        app_response(message: "Car uploaded successfully", status: :created, data: {car: car_attributes})
    end

    def show
        blob = ActiveStorage::Blob.find(params[:id])
        if blob.present?
            img = url_for(blob)
            app_response(data: "img")
        else
        head :not_found
        end
    end


    private
    def car_params
        params.require(:car).permit(:model, :brand, :price, :year_of_manufacture, :image)
    end
end
