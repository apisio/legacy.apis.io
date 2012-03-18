class FollowsController < ApplicationController

  before_filter :current_user  

  # GET /follows
  # GET /follows.json
  def index
    
    if params[:user] and isNumeric(params[:user])
      @user = User.find(params[:user])
    else
      # @user = User.find_by_username(params[:user])
      if request.url.index('localhost')
        @user = User.find(:first, :conditions => ['username LIKE ?', params[:user]])
       else
        @user = User.find(:first, :conditions => ['username ILIKE ?', params[:user]])
      end
      
    end

    if @user    
      if params[:view] == 'following'
        # Following
        @follows = Follow.paginate :page => params[:page], :conditions => ["user_id = ?", @user.id], :order => "updated_at DESC"
      else
        # Followers
        @follows = Follow.paginate :page => params[:page], :conditions => ["follow_id = ?", @user.id], :order => "updated_at DESC"
      end 
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render @follows.to_json }
    end
  end

  # GET /follows/1
  # GET /follows/1.json
  def show
    @follow = Follow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render @follows.to_json }
    end
  end

  # GET /follows/new
  # GET /follows/new.json
  def new
    @follow = Follow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render @follows.to_json }
    end
  end

  # GET /follows/1/edit
  def edit
    @follow = Follow.find(params[:id])
  end

  # POST /follows
  # POST /follows.json
  def create
    
    # Follow or Unfollow based on status param in AJAX
      @followbutton = params[:id] 
      
   # Check to see if blocked before allowing follow
    # @blocker = Follow.find(:first, :conditions => ["user_id = ? and block_id = ?", params[:id], session["user_id"]])
    
    # if @blocker
    #   @blocked = true
      
    if params[:status] == "follow"
      @follow = Follow.new(params[:follow])    
      @follow.user_id = session["user_id"]
      @follow.follow_id = params[:id]    
      @follow.save      
      
      @status = Status.new
      @status.user_id = session["user_id"]
      @status.api_id = params[:id]   
      @status.message = "Followed API"
      @status.save
      

    else # unfollow
      @follow = Follow.find(:first, :conditions => ["user_id = ? and follow_id = ?", session["user_id"], params[:id]])
      if @follow
        
        @status = Status.new
        @status.user_id = session["user_id"]
        @status.api_id = params[:id]   
        @status.message = "Unfollowed API"
        @status.save
        
        @follow.destroy
      end      
    end

    @api = Api.find(params[:id])
    @followers = Follow.count(:conditions => ["follow_id = ?", @api.id])
    
    
    respond_to do |format|  
      format.js { render :action => 'create.js.coffee', :content_type => 'text/javascript'}
    end
    
  end

  # PUT /follows/1
  # PUT /follows/1.json
  def update
    @follow = Follow.find(params[:id])

    respond_to do |format|
      if @follow.update_attributes(params[:follow])
        format.html { redirect_to @follow, :notice => 'Follow was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render @follow.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def block

    @block = true
    @followbutton = params[:id] 
    
    # Unfollow before blocking (both parties)
    @unfollow = Follow.find(:first, :conditions => ["user_id = ? and follow_id = ?", session["user_id"], params[:id]])
    if @unfollow
      @unfollow.destroy
    end      
    @unfollowee = Follow.find(:first, :conditions => ["user_id = ? and follow_id = ?", params[:id], session["user_id"]])
    if @unfollowee
      @unfollowee.destroy
    end      
    
    # Add user block to follows table
    @follow = Follow.new   
    @follow.user_id = session["user_id"]
    @follow.block_id = params[:id]    
    @follow.save      

    @user = User.find(params[:id])

    render :action => 'create.js.coffee', :content_type => 'text/javascript'
		
  end

  def unblock

    @unblock = true
    @followbutton = params[:id] 
    
    @follow = Follow.find(:first, :conditions => ["user_id = ? and block_id = ?", session["user_id"], params[:id]])
    if @follow
      @follow.destroy
    end      

    @user = User.find(params[:id])

    render :action => 'create.js.coffee', :content_type => 'text/javascript'
		
  end

  # DELETE /follows/1
  # DELETE /follows/1.json
  def destroy
    @follow = Follow.find(params[:id])
    if session["user_id"] == @follow.user_id
      @follow.destroy
    end

    respond_to do |format|
      format.html { redirect_to follows_url }
      format.json { head :ok }
    end
  end
end
