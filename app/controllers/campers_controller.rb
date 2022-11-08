class CampersController < ApplicationController


rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    def index 
        campers= Camper.all
        render json: campers, status: :ok
    end

    def show
        camper = find_camper
        render json: camper.to_json(include: [:activities]), status: :ok
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end
    

    private

    def camper_params
        params.permit(:name, :age)
    end

    def find_camper
        Camper.find(params[:id])
    end

    def not_found (exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end

