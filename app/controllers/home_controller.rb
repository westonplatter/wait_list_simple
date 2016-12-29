require 'base64'

class HomeController < ApplicationController
  def index

    if params_referral_hash
      @referral_hash = 'xyz890'
    end
  end

  def signup
    @user = User.find_by(email: params_email)

    if @user.nil?
      @user = User.create(email: params_email, password: 'password_to_satisfy_devise_constrait')
    end

    # unless params_referral_hash.nil?
    #   x = Base64.decode64(params_referral_hash)
    #   if x.include?("|")
    #     email, id = x.split("|")
    #     @referring_user = User.find_by(email: email, id: id)
    #     @referring_user.increment_position if @referring_user
    #   end
    # end

    spot = @user.position

    flash[:info] = "thanks for signing up with #{@user.email}. you're ##{@user.position} on the wait list"

    redirect_to root_path(referral_hash: 'abc123')
  end


  private

  def params_referral_hash
    params[:referral_hash]
  end

  def params_email
    #
    # this ensures that emails (weston+1@example.com, weston+2@example.com) are
    # treated singularly as weston@example.com
    #
    begin
      x = params[:email].split("@")
      username = x[0].split("+")[0]
      domain = x[1]
      email = "#{username}@#{domain}"
      return email
    rescue Exception => e
      # not good to catch exceptions, so you want to fix/change this before going into production with this
    end
  end
end
