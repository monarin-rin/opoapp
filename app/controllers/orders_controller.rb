class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:customer, :invoice).all  # 受注に関連する顧客と請求書も同時に取得
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      create_invoice_if_requested(@order)  # メソッドの呼び出し
      redirect_to orders_path, notice: "受注が作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])  # 編集対象の受注を取得
  end

  def update
    @order = Order.find(params[:id])  # 編集対象の受注を取得
    if @order.update(order_params)
      redirect_to orders_path, notice: "受注が更新されました。"
    else
      render :edit  # バリデーションエラーがあれば再度editページを表示
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path, notice: "受注が削除されました。"
  end

  private

  def order_params
    params.require(:order).permit(:name, :description, :customer_id).merge(create_invoice: params[:order][:create_invoice].present? ? params[:order][:create_invoice] : "0")
  end

  # 請求書作成をチェックした場合に実行
  def create_invoice_if_requested(order)
    if params[:order][:create_invoice] == "1"
      invoice = order.build_invoice(
        invoice_date: Date.today,
        amount: calculate_invoice_amount(order),
        status: "未払い"
      )
      unless invoice.save
        flash[:alert] = "請求書の作成に失敗しました。"
      end
    end
  end

  # 請求書の金額計算 (受注に関連する商品の合計金額を計算)
  def calculate_invoice_amount(order)
    order.order_items.sum { |item| item.quantity * item.product.price }
  end
end
