class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to orders_path  # ログイン済みユーザーは受注一覧へ
    else
      render "home/index"  # 未ログインユーザーにはホームページを表示
    end
  end
end
