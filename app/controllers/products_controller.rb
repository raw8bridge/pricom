class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products
  def index
    @products = params[:category_id].present? ? Product.where(category_id: params[:category_id]) : Product.all
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @category_id = Category.exists?(id: params[:category_id]) ? params[:category_id] : nil
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @category_id = @product.category_id
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to category_products_path(category_id: @product.category_id), notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to category_products_path(category_id: @product.category_id), notice: "Product was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
    redirect_to products_url, notice: "Product was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :supplement, :category_id)
    end
end
