class ApplicationController < ActionController::Base
  protect_from_forgery
    
  # unless config.consider_all_requests_local
  #     rescue_from Exception, :with => :render_error
  #     rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  #     rescue_from ActionController::RoutingError, :with => :render_not_found
  #     rescue_from ActionController::UnknownController, :with => :render_not_found
  #     # customize these as much as you want, ie, different for every error or all the same
  #     rescue_from ActionController::UnknownAction, :with => :render_not_found
  # end

  def omniauth
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
    end
  end
  helper_method :current_user
  
  def admin_required
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
    end

    if @current_user 
      if @current_user.admin != true
        redirect_to '/'
      end
    else
       redirect_to '/'
    end
  end

  def trustee_required
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
    end

    if @current_user 
      @followers = Follow.count(:conditions => ["follow_id = ?", @current_user.id])
      if @followers < 10 
        if @current_user.trustee != true 
          redirect_to '/'
        end
      end
    else
       redirect_to '/'
    end
  end
  
  def user_signed_in?
    return 1 if current_user 
  end
  

  def login_required
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
    end

    if !@current_user 
       redirect_to '/'
    end
  end

  def isNumeric(s)
      Float(s) != nil rescue false
  end
    
  private

    def render_not_found(exception)
      render :template => "/errors/404.html.erb", :status => 404
      # render :template => "/twitter", :status => 404
    end

    def render_error(exception)
      # you can insert logic in here too to log errors
      # or get more error info and use different templates
      render :template => "/errors/500.html.erb", :status => 500
    end

end
