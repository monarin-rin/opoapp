# app/pdfs/invoice_pdf.rb
class InvoicePdf < Prawn::Document
  def initialize(invoice)
    super()
    @invoice = invoice
    header
    invoice_details
    order_items
    totals
  end

  def header
    text "適格請求書", size: 20, style: :bold
    move_down 10
    text "適格請求書発行事業者登録番号: #{@invoice.company_tax_id}", size: 12
    text "請求書番号: #{@invoice.invoice_number}", size: 12
    text "会社名: #{@invoice.company_name}", size: 12
    text "会社住所: #{@invoice.company_address}", size: 12
    text "顧客名: #{@invoice.customer_name}", size: 12
    text "顧客住所: #{@invoice.customer_address}", size: 12
    text "請求日: #{@invoice.invoice_date.strftime('%Y年%m月%d日') if @invoice.invoice_date}", size: 12
    move_down 20
  end

  def invoice_details
    text "商品明細", size: 14, style: :bold
    move_down 10
    table([ [ "商品名", "数量", "単価", "税率", "消費税額", "小計" ] ]) do
      row(0).font_style = :bold
    end
  end

  def order_items
    @invoice.order.order_items.each do |item|
      table([ [
        item.product.name,
        item.quantity,
        "¥#{number_to_currency(item.product.price, unit: "")}",
        "#{item.product.tax_rate}%",
        "¥#{number_to_currency(item.quantity * item.product.price * (item.product.tax_rate / 100.0), unit: "")}",
        "¥#{number_to_currency(item.quantity * item.product.price, unit: "")}"
      ] ])
    end
  end

  def totals
    move_down 10
    text "合計（税込）: ¥#{number_to_currency(@invoice.total_amount, unit: "")}", size: 12
    text "税率 10%: ¥#{number_to_currency(@invoice.tax_amount, unit: "")}", size: 12
    text "税率 8%: ¥#{number_to_currency(@invoice.tax_amount * 0.8, unit: "")}", size: 12
  end
end
