class StatusesController < ApplicationController
  
  require 'rubygems'
  require 'open-uri'
  require 'cgi'
  require 'rest-client'
  
  
  # GET /statuses
  # GET /statuses.json
  def index
    # @statuses = Status.find(:all, :order => "created_at DESC")
    @statuses = Status.paginate :page => params[:page], :order => 'created_at DESC' #, :per_page => 3
    @following = Follow.count(:all, :conditions => ["user_id = ?", session["user_id"]])
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end

  def pollfeed
    @statuses = Status.paginate :page => params[:page], :order => 'created_at DESC', :conditions=>['created_at > ?', Time.now - 10.seconds]                
    respond_to do |format|  
      format.js { render :action => 'pollfeed.js.coffee', :content_type => 'text/javascript'}
    end 
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.json
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  def create
    
    # API Status Update - Basic Authentication
    if !session["user_id"]
      authenticate_or_request_with_http_basic do |username, password|
        if request.url.index('localhost')
          user = User.find(:first, :conditions => ['username LIKE ?', username.strip])
        else
          user = User.find(:first, :conditions => ['username ILIKE ?', username.strip])
        end

        if user && user.authenticate(password)
          session["user_id"] = user.id
        end
      end
    end
    

    respond_to do |format|
      
      if params[:status] and params[:status][:message] 
        postmessage = params[:status][:message]
      elsif params[:message] 
        postmessage = params[:message]
      end
      
      if session["user_id"] and postmessage

        @status = Status.new 
        @status.user_id = session["user_id"]
        @status.message = postmessage    
        @status.save            
        
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.js { render :action => 'create.js.coffee', :content_type => 'text/javascript'}
        format.json { render :json => @status}
      else
        format.html { render action: "new" }
        format.json {   }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    if session["user_id"] == @status.user_id
      @status.destroy
    end

    respond_to do |format|
      format.html { redirect_to statuses_url }
      # format.json { head :ok }
      format.js { render :action => 'destroy.js.coffee', :content_type => 'text/javascript'}
    end
  end  
  
end
