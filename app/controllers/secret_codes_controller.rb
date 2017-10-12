class SecretCodesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

  def index
  	@sc = SecretCode.new
  	@codes = SecretCode.left_joins(:user).select("secret_codes.*, users.email as user_email").order("created_at desc")
  end

  def create
  	SecretCode.generate_codes(params[:count].to_i)
		flash[:notice] = "Successfully created..."
  	redirect_to secret_codes_path
  end
end
