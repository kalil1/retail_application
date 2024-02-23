module Api
  class ProductsController < ApplicationController
    def index
      @products = Product.where(status: 'active').order(created_at: :desc)
      render json: @products
    end

    def search
      # Implement search logic based on params
    end

    def create
      # Implement create logic with price validation
    end

    def update
      @product = Product.find(params[:id])
      if params[:price] && @product.price * 1.5 < params[:price].to_f
        @product.update(status: 'pending')
        Approval.create(product: @product, status: 'pending', request_date: DateTime.now)
        render json: { message: 'Product update requires approval.' }
      else
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.update(status: 'pending')
      Approval.create(product: @product, status: 'pending', request_date: DateTime.now)
      render json: { message: 'Product deletion requires approval.' }
    end

    def approval_queue
      @approval_queue = Approval.all.order(request_date: :asc).map(&:product)
      render json: @approval_queue
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :status)
    end
  end
end