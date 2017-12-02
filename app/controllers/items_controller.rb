class ItemsController < ApplicationController
	before_action :set_item, only: [:show,:edit,:update,:destroy]
	before_action :list_categories, only: [:new,:edit]
	def index
		@items = Item.all.order('category_id,id')
		@categories = Category.all.index_by(&:id)
	end

	def new
		@item = Item.new
	end

	def edit
		#共通メソッド(set_item動作)
	end

	def create
	  	@item = Item.new(item_params)
	  	@item.save
		#登録後は費目一覧に戻す
		redirect_to items_path
	end

	def update
		#共通メソッド(set_item動作)
		# params.require(:item) >送られてきているパラメータの「item」のパラメータを取得する

		@item.update(item_params)
		#更新後は費目一覧に戻す
		redirect_to items_path
	end

	def destroy
		#共通メソッド(set_item動作)
		@item.destroy
		redirect_to items_path
	end

	def list_categories
		@categories_list = Category.select(:id,:name)
	end

	# 以下共通メソッド
	def set_item
		@item = Item.find params[:id]
	end

	def item_params
		params.require(:item).permit(:name,:description,:category_id)
	end
end
