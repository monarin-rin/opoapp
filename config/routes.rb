Rails.application.routes.draw do
  # Deviseルーティング（ログイン機能）
  devise_for :users

  # 顧客管理機能
  resources :customers

  # 受注と請求書の関連ルート
  resources :orders do
    resource :invoice, only: [ :new, :create ]
  end

  # 請求書管理機能
  resources :invoices, only: [ :index, :show, :edit, :update, :destroy ] do
    # 追加: PDFダウンロード用のルート
    member do
      get :download_pdf  # PDFを生成してダウンロードするアクション
    end
  end

  # その他のリソース
  resources :purchase_orders

  # ルートページ（受注一覧をデフォルトに設定）
  root to: "orders#index"

  resources :products
end
