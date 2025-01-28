class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  # 商品一覧
  def index
    @products = Product.all
  end

  # 商品詳細
  def show
  end

  # 新規商品作成フォーム
  def new
    @product = Product.new
  end

  # 商品の作成
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "商品が作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 商品編集フォーム
  def edit
  end

  # 商品の更新
  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "商品が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 商品の削除
  def destroy
    @product.destroy
    redirect_to products_path, notice: "商品が削除されました。"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :tax_rate, :category, :description)
  end
end
