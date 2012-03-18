class ParametersController < ApplicationController
  # GET /parameters
  # GET /parameters.json
  def index
    @parameters = Parameter.all

    respond_to do |format|
      format.html {redirect_to "/"}# index.html.erb
      format.json { render json: @parameters }
    end
  end

  # GET /parameters/1
  # GET /parameters/1.json
  def show
    @parameter = Parameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parameter }
    end
  end

  # GET /parameters/new
  # GET /parameters/new.json
  def new
    @parameter = Parameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parameter }
    end
  end

  # GET /parameters/1/edit
  def edit
    @parameter = Parameter.find(params[:id])
  end

  # POST /parameters
  # POST /parameters.json
  def create
    @parameter = Parameter.new(params[:parameter])

    respond_to do |format|
      if @parameter.save
        
        @status = Status.new
        @status.user_id = session["user_id"]
        @status.api_id = @parameter.api_id
        @status.message = "Added new " + @parameter.paramstyle.capitalize + " parameter to " + @parameter.resource.resourcename.capitalize + " API"
        @status.save
        
        format.html { redirect_to @parameter, notice: 'Parameter was successfully created.' }
        format.json { render json: @parameter, status: :created, location: @parameter }
        format.js { render :action => 'create.js.coffee', :content_type => 'text/javascript'}
        
      else
        format.html { render action: "new" }
        format.json { render json: @parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parameters/1
  # PUT /parameters/1.json
  def update
    @parameter = Parameter.find(params[:id])
    
    if params[:parameter][:paramstyle] == "header"
      @parameter.paramtype = "xsd:string"
    end

    respond_to do |format|
      if @parameter.update_attributes(params[:parameter])
        
        @status = Status.new
        @status.user_id = session["user_id"]
        @status.api_id = @parameter.api_id
        @status.message = "Updated " + @parameter.paramstyle.capitalize + " parameter to " + @parameter.resource.resourcename.capitalize + " API"
        @status.save
        
        
        format.html { redirect_to '/' + @parameter.resource.api.name, notice: 'Parameter was successfully updated.' }
        # format.html { redirect_to @parameter, notice: 'Parameter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parameters/1
  # DELETE /parameters/1.json
  def destroy
    @parameter = Parameter.find(params[:id])
    
    @status = Status.new
    @status.user_id = session["user_id"]
    @status.api_id = @parameter.api_id
    @status.message = "Deleted " + @parameter.paramstyle.capitalize + " parameter from " + @parameter.resource.resourcename.capitalize + " API"
    @status.save
    
    @parameter.destroy

    respond_to do |format|
      format.html { redirect_to parameters_url }
      format.json { head :no_content }
      format.js { render :action => 'destroy.js.coffee', :content_type => 'text/javascript'}
    end
  end
end
