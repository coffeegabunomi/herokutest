class CategoriesController < ApplicationController
	require "colorable"
	before_action :set_category, only: [:show,:edit,:update,:destroy]

	def index
		@categories = Category.all.order(:id)
	end

	def new
		@category = Category.new
	end

	def edit

	end

	def update
		@category.update(category_params)
		#更新後は費目一覧に戻す
		redirect_to categories_path
	end

	def create
	  	@category = Category.new(category_params)
	  	@category.save
		#登録後は費目一覧に戻す
		redirect_to categories_path
	end
	
	def destroy
		#共通メソッド(set_category動作)
		@category.destroy
		redirect_to categories_path
	end

	# 以下共通メソッド
	def set_category
		@category = Category.find params[:id]
	end

	def category_params
		set_params_data = params.require(:category).permit(:name,:description,:colorcode,:defaultmoney)

		c_code = Colorable::Color.new set_params_data["colorcode"]
		set_params_data.store("colorred", c_code.rgb[0])
		set_params_data.store("colorgreen", c_code.rgb[1])
		set_params_data.store("colorblue", c_code.rgb[2])
		params = set_params_data
	end


end
