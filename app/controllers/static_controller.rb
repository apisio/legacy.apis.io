class StaticController < ApplicationController
  before_filter :current_user  
  
  require 'open-uri'
  
  def index
    if session["user_id"]
      redirect_to "/apis"
    end
  end  
  
end
