class ApisController < ApplicationController
  # GET /apis
  # GET /apis.json
  def index
    @apis = Api.paginate :page => params[:page], :order=>"name"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apis }
    end
  end

  def search
    if request.url.index('localhost')
      @apis = Api.paginate :page => params[:page], :conditions => ['name LIKE ? or description LIKE ? or category LIKE ?', '%' + params[:id] + '%', '%' + params[:id] + '%', '%' + params[:id] + '%'], :order=>"name"
     else
      @apis = Api.paginate :page => params[:page], :conditions => ['name ILIKE ? or description ILIKE ? or category ILIKE ?', '%' + params[:id] + '%', '%' + params[:id] + '%', '%' + params[:id] + '%'], :order=>"name"
    end

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @apis }
    end
  end

  # GET /apis/1
  # GET /apis/1.json
  def show
    if params[:id] and isNumeric(params[:id])
      @api = Api.find(params[:id])
    else
      
      if request.url.index('localhost')
        @api = Api.find(:first, :conditions => ['name LIKE ?', params[:id]])
       else
        @api = Api.find(:first, :conditions => ['name ILIKE ?', params[:id]])
      end
    
    end
    
    if @api
      
      @follow = Follow.find(:first, :conditions => ["user_id = ? and follow_id = ?", session[:user_id], @api.id])      
      @followers = Follow.count(:conditions => ["follow_id = ?", @api.id])
      
      @resources = Resource.find(:all, :conditions => ["api_id = ?", @api.id], :order => "resourcename, resourcemethod")
    
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api }
    end
  end

  # GET /apis/new
  # GET /apis/new.json
  def new
    @api = Api.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api }
    end
  end

  # GET /apis/1/edit
  def edit
    if params[:id] and isNumeric(params[:id])
      @api = Api.find(params[:id])
    else
      
      if request.url.index('localhost')
        @api = Api.find(:first, :conditions => ['name LIKE ?', params[:id]])
      else
        @api = Api.find(:first, :conditions => ['name ILIKE ?', params[:id]])
      end
    
    end
    
  end

  # POST /apis
  # POST /apis.json
  def create
    @api = Api.new(params[:api])

    respond_to do |format|
      if @api.save
        format.html { redirect_to '/' + @api.name, notice: 'Api was successfully created.' }
        format.json { render json: @api, status: :created, location: @api }
      else
        format.html { render action: "new" }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apis/1
  # PUT /apis/1.json
  def update
    if params[:id] and isNumeric(params[:id])
      @api = Api.find(params[:id])
    else
      
      if request.url.index('localhost')
        @api = Api.find(:first, :conditions => ['name LIKE ?', params[:id]])
      else
        @api = Api.find(:first, :conditions => ['name ILIKE ?', params[:id]])
      end
    
    end
    
    respond_to do |format|
      if @api.update_attributes(params[:api])
        format.html { redirect_to '/' + @api.name, notice: 'Api was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apis/1
  # DELETE /apis/1.json
  def destroy
    @api = Api.find(params[:id])
    @api.destroy

    respond_to do |format|
      format.html { redirect_to apis_url }
      format.json { head :no_content }
    end
  end
  
  def import
    if params[:id] and isNumeric(params[:id])
      @api = Api.find(params[:id])
    else
      
      if request.url.index('localhost')
        @api = Api.find(:first, :conditions => ['name LIKE ?', params[:id]])
       else
        @api = Api.find(:first, :conditions => ['name ILIKE ?', params[:id]])
      end
    
    end
    
  end
  
  def wadl_import
    
    # TODO: Add support for multiple resources in a wadl file

    @api_id =  params[:dump][:api]
    
    # Bail if API doesn't belong to you.
    @api = Api.find(@api_id)
    if @api and @api.user_id != session["user_id"]
      return
    end

    @importcount = 0
      
    Resource.delete_all(["api_id = ?", @api_id])
    Parameter.delete_all(["api_id = ?", @api_id])
    
    content =  params[:dump][:file].read


    @doc = Nokogiri::XML(content)

    # Remove appigee or apisio xml namspaces on tags
    @doc.remove_namespaces!

    @doc.search('*/resource').each do |node|
      
    	node.search('method').each do |meth|
    	
    	  @resource = Resource.new
        @resource.api_id = @api_id

      	@resource.pathurl = node['path']
      
    	  @resource.resourcemethod =  meth["name"]

    	  @resource.description =  meth.search('doc').text.gsub(/\s+/, " ").strip

    	  @resource.docurl =  meth.xpath('doc')[0]["url"]

        # puts "resource name:" + meth.xpath('tags/tag')[0].text 
        meth.search('tags/tag').each do |tag| 
          if tag["primary"] == "true"
            @resource.resourcename = tag.text 
          end
        end

        if meth.xpath('authentication')[0]["required"] == "true"
          @resource.authentication = "Basic"
        else
          @resource.authentication = "None"
        end 
          
        @resource.curlexample = meth.xpath('example')[0]["url"] 

      	@resource.save 
      	
        # Add resource parameters
      	meth.search('request/param').each do |param| 
      	  
      	  @parameter = Parameter.new
          @parameter.api_id = @api_id
          @parameter.resource_id = @resource.id

          @parameter.paramname = param["name"]
          @parameter.paramtype = param["type"]
          @parameter.paramdefault = param["default"]
          @parameter.paramstyle = param["style"]
          @parameter.description = param.search('doc').text.gsub(/\s+/, " ").strip
          if param["required"]
            @parameter.paramrequired = true
          else
            @parameter.paramrequired = false
          end 
          @parameter.save
          
        end
        
        payload = meth.search('request/representation/payload').text.gsub(/\s+/, " ").strip
        if payload
      	  @parameter = Parameter.new
          @parameter.api_id = @api_id
          @parameter.resource_id = @resource.id
          @parameter.payload = payload
          @parameter.save          
        end
        

    	end
    	
    	
    end


    
    redirect_to("/" + @api.name)

  end
  
  def export
    
    if params[:id] and isNumeric(params[:id])
      @api = Api.find(params[:id])
    else
      
      if request.url.index('localhost')
        @api = Api.find(:first, :conditions => ['name LIKE ?', params[:id]])
      else
        @api = Api.find(:first, :conditions => ['name ILIKE ?', params[:id]])
      end
    
    end
    
    @resources = Resource.find(:all, :conditions => ["api_id = ?", @api.id], :order => 'resourcename')
    
    @data = '<?xml version="1.0" encoding="UTF-8"?>
    <application xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
      xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:apisio="http://api.apis.io/wadl/2012/03/" 
      xmlns="http://wadl.dev.java.net/2009/02"
      xsi:schemaLocation="http://wadl.dev.java.net/2009/02 http://apisio.com/schemas/wadl-schema.xsd http://api.apisio.com/wadl/2012/03/ http://apisio.com/schemas/apisio-wadl-extensions.xsd">

      <!-- Base defines the domain and base path of the endpoint --> 
      <resources base="' + @api.apiurl + '">' + "\n" 
    
    @resources.each do |resource|
      
      @data << '<resource path="' + resource.pathurl + '">' + "\n" 
      
      resname = ""
      while resource.resourcename != resname do        
 
        @data << '<method id="' + resource.resourcename + '_' + resource.resourcemethod + '" name="' + resource.resourcemethod + '" apisio:displayName="' + resource.resourcename + '_' + resource.resourcemethod + '">' + "\n" 

        @data << '<apisio:tags><apisio:tag primary="true">' + resource.resourcename + '</apisio:tag></apisio:tags>' + "\n" 

        if resource.authentication == "None"
          @data << '<apisio:authentication required="false" />' + "\n" 
        else
          @data << '<apisio:authentication required="true" />' + "\n" 
        end
        
        @data << '<apisio:example url="' + resource.curlexample + '" />' + "\n" 

        @data << '<doc title="" apisio:url="' + resource.docurl + '">' + resource.description + '</doc>' + "\n" 

        # TODO: Add Params
        @data << '<request></request>' + "\n" 

    		@data << '</method>' + "\n" 

  			resname = resource.resourcename 
  		end 
  		
  		@data << '</resource>' + "\n" 

    end
    
    @data << '</resources>' + "\n" 
    @data << '</application>' + "\n" 
    
    send_data(@data,
          :type => 'text/xml',
          :filename => params[:id].downcase + '.wadl')
    
  end
  
  
  
end
