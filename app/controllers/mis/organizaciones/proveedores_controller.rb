class Mis::Organizaciones::ProveedoresController < ApplicationController
include Globales, Globales::Empresa
	def index
		render json: @collection
	end

	def show
		render json: @item
	end

	def new
		render json: new_item, except: :id
	end

	def create
		if @item.save
			head :no_content
		else
			render json: {errors: @item.errors.full_messages}, status: 422
		end
	end

	def update
		if @item.update(item_params)
			head :no_content
		else
			render json: {errors: @item.errors.full_messages}, status: 422
		end
	end

	def destroy
		if @item.destroy
			head :no_content
		else
			render json: {errors: @item.errors.full_messages}, status: 422
		end
	end

end
