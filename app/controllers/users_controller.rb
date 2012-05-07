class UsersController < ApplicationController

  before_filter :login_required, :except => [:show]
  

  # GET /users/1
  # GET /users/1.json
  def show
    
    if params[:id] and isNumeric(params[:id])
      @user = User.find(params[:id])
    else
      if request.url.index('localhost')
        @user = User.find(:first, :conditions => ['username LIKE ?', params[:id]])
       else
        @user = User.find(:first, :conditions => ['username ILIKE ?', params[:id]])
      end            
    end
    
    if @user
            
      @following = Follow.find(:all, :conditions => ["user_id = ?", @user.id])
      # @activities = Activity.paginate :page => params[:page], :conditions => ['user_id = ?', @user.id], :order => 'activities.updated_at DESC'     
            
    else
      redirect_to "/errors/404"
    end #@user
    
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json 
    # end
  end
  

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    
    if session[:user_id] == @user.id
      @user.destroy
      session[:user_id] = nil
    end

    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :ok }
    end
  end
  
  
end
