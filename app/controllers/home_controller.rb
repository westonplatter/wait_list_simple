class HomeController < ApplicationController
  def index

    if params[:referral_hash]
      @referral_hash = 'xyz890'
    end
  end

  def signup
    email = params[:email]

    referral_hash = params[:referral_hash]

    spot = 1

    flash[:info] = "thanks for signing up with #{email}. you're #{spot} on the wait list"

    redirect_to root_path(referral_hash: 'abc123')
  end
end
