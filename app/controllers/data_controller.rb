class DataController < ApplicationController
  before_action :set_datum, only: %i[ show edit update destroy ]

  # GET /data
  def index
    @category_id = Category.exists?(id: params[:category_id]) ? params[:category_id] : nil
    @data = params[:product_id].present? ? Datum.where(product_id: params[:product_id]).order(date: :desc) : Datum.all
  end

  # GET /data/1
  def show
  end

  # GET /data/new
  def new
    @category_id = Category.exists?(id: params[:category_id]) ? params[:category_id] : nil
    @product_id = Product.exists?(id: params[:product_id]) ? params[:product_id] : nil
    @datum = Datum.new
  end

  # GET /data/1/edit
  def edit
  end

  # POST /data
  def create
    @datum = Datum.new(datum_params)

    if @datum.save
      redirect_to category_product_data_path(category_id: @datum.product.category_id, product_id: @datum.product_id), notice: "Datum was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data/1
  def update
    if @datum.update(datum_params)
      redirect_to category_product_data_path(category_id: @datum.product.category_id, product_id: @datum.product_id), notice: "Datum was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /data/1
  def destroy
    @datum.destroy!
    redirect_to data_url, notice: "Datum was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datum
      @datum = Datum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def datum_params
      params.require(:datum).permit(:price, :date, :product_id, :shop_id)
    end
end
