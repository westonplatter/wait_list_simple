require 'securerandom'

class HomeController < ApplicationController
  def index
    @referral_hash = params_referral_hash if params_referral_hash
  end

  def signup
    @user = User.find_by(email: params_email)

    if @user.nil?
      uuid = SecureRandom.uuid

      @user = User.create(
        email: params_email,
        password: 'password_to_satisfy_devise_constrait',
        referral_hash: uuid)
    end

    unless params_referral_hash.blank?
      @referring_user = User.where(referral_hash: params_referral_hash).first
      @referring_user.move_higher if (@referring_user and @referring_user.email != params_email)
    end

    spot = @user.position

    flash[:info] = "thanks for signing up with #{@user.email}. you're ##{@user.position} on the wait list"

    redirect_to root_path(referral_hash: @user.referral_hash)
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
      raise e
    end
  end
end
