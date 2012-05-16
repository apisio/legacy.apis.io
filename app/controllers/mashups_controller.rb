class MashupsController < ApplicationController
  # GET /mashups
  # GET /mashups.json
  def index
    
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    @page = @page + 1
    
    @mashups = Mashup.paginate :page => params[:page], :order=>"mashupname", :per_page => 100

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @mashups }
    # end
  end

  # GET /mashups/1
  # GET /mashups/1.json
  def show
    if params[:id] and isNumeric(params[:id])
      @mashup = Mashup.find(params[:id])
    else
      
      if request.url.index('localhost')
        @mashup = Mashup.find(:first, :conditions => ['mashupname LIKE ?', params[:id]])
      else
        @mashup = Mashup.find(:first, :conditions => ['mashupname ILIKE ?', params[:id]])
      end
    
    end


    if @mashup
      
      @follow = Follow.find(:first, :conditions => ["user_id = ? and follow_id = ?", session[:user_id], @mashup.api_id])      
      @followers = Follow.count(:conditions => ["follow_id = ?", @mashup.api_id])
          
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mashup }
    end
  end

  # GET /mashups/new
  # GET /mashups/new.json
  def new
    @mashup = Mashup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mashup }
    end
  end

  # GET /mashups/1/edit
  def edit
    @mashup = Mashup.find(params[:id])
  end

  # POST /mashups
  # POST /mashups.json
  def create
    @mashup = Mashup.new(params[:mashup])

    respond_to do |format|
      if @mashup.save
        format.html { redirect_to @mashup, notice: 'Mashup was successfully created.' }
        format.json { render json: @mashup, status: :created, location: @mashup }
      else
        format.html { render action: "new" }
        format.json { render json: @mashup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mashups/1
  # PUT /mashups/1.json
  def update
    if params[:id] and isNumeric(params[:id])
      @mashup = Mashup.find(params[:id])
    else
      
      if request.url.index('localhost')
        @mashup = Mashup.find(:first, :conditions => ['mashupname LIKE ?', params[:id]])
      else
        @mashup = Mashup.find(:first, :conditions => ['mashupname ILIKE ?', params[:id]])
      end
    
    end
    
    respond_to do |format|
      if @mashup.update_attributes(params[:mashup])
        format.html { redirect_to @mashup, notice: 'Mashup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mashup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mashups/1
  # DELETE /mashups/1.json
  def destroy
    @mashup = Mashup.find(params[:id])
    
    if session["user_id"] == @mashup.user_id  or session["admin"]     
      @mashup.destroy 
    end 
    
    respond_to do |format|
      format.html { redirect_to mashups_url }
      format.json { head :no_content }
    end
  end
end
