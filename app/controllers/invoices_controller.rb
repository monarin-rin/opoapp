class InvoicesController < ApplicationController
  before_action :set_invoice, only: [ :show, :edit, :update, :destroy ]

  # 請求書一覧
  def index
    @invoices = Invoice.all
  end

  # 請求書詳細
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice)
        send_data pdf.render,
                  filename: "invoice_#{@invoice.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"  # inlineで表示。ダウンロードを強制したい場合は"attachment"に変更
      end
    end
  end

  # 新規請求書フォーム
  def new
    @order = Order.find(params[:order_id])  # 受注IDに基づいて注文を取得
    @invoice = @order.build_invoice  # 受注に関連する新規請求書を作成
  end

  # 請求書の作成
  # 請求書の作成
  def create
    @order = Order.find(params[:order_id])
    @invoice = @order.build_invoice(invoice_params)  # パラメータを使って請求書を作成
    @invoice.tax_amount = calculate_tax(@invoice.total_amount, @invoice.tax_rate)  # 税額計算

    if @invoice.save
    redirect_to @invoice, notice: "請求書が作成されました。"
    else
    render :new, status: :unprocessable_entity  # バリデーションエラーがあれば新規作成フォームを再表示
    end
  end


  # 編集画面
  def edit
  end

  # 更新処理
  def update
    @invoice.tax_amount = calculate_tax(@invoice.total_amount, @invoice.tax_rate)

    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "請求書が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  def destroy
    @invoice.destroy
    redirect_to invoices_path, notice: "請求書が削除されました。"
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :company_name, :company_address, :company_tax_id, :customer_name, :customer_address, :tax_rate, :total_amount, :invoice_date, :status)
  end

  def calculate_tax(total_amount, tax_rate)
    (total_amount * (tax_rate / 100)).round(2)
  end
end
