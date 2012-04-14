class ResourcesController < ApplicationController
  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html {redirect_to "/"}# index.html.erb
      format.json { render json: @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        
        @status = Status.new
        @status.user_id = session["user_id"]
        @status.api_id = @resource.api_id
        @status.message = "Added new " + @resource.resourcename.capitalize + " " + @resource.resourcemethod + " resource to " + @resource.api.name.capitalize + " API"
        @status.save
        
        
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: @resource }
        format.js { render :action => 'create.js.coffee', :content_type => 'text/javascript'}
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        
        @status = Status.new
        @status.user_id = session["user_id"]
        @status.api_id = @resource.api_id
        @status.message = "Updated " + @resource.resourcename.capitalize + " " + @resource.resourcemethod + " resource to " + @resource.api.name.capitalize + " API"
        @status.save
        
        
        format.html { redirect_to '/' + @resource.api.name, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource = Resource.find(params[:id])
    
    if session["user_id"] == @resource.user_id  or session["admin"]
    
      @status = Status.new
      @status.user_id = session["user_id"]
      @status.api_id = @resource.api_id
      @status.message = "Deleted " + @resource.resourcename.capitalize + " " + @resource.resourcemethod + " resource to " + @resource.api.name.capitalize + " API"
      @status.save
        
      @resource.destroy

    end

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
      format.js { render :action => 'destroy.js.coffee', :content_type => 'text/javascript'}
    end
  end
end
