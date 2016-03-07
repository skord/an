class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  def index
    @authentications = current_user.authentications
  end

  def create
    auth = request.env['omniauth.auth']
    current_auth = current_user.authentications.find_or_create_by(provider: auth['provider'], uid:auth['uid'])
    current_auth.info= auth['info']
    current_auth.extra= auth['extra']
    current_auth.credentials = auth['credentials']
    current_auth.save
    flash[:notice] = 'Auth successful!'
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Account unlinked"
    redirect_to authentications_url
  end
end
