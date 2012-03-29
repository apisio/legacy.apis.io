class ExplorersController < ApplicationController
  
  # require "Yajl"
  
  # GET /explorers
  # GET /explorers.json
  def index
    # @explorers = Explorer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @explorers }
    end
  end

  # GET /explorers/1
  # GET /explorers/1.json
  def show
    @explorer = Explorer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @explorer }
    end
  end

  # GET /explorers/new
  # GET /explorers/new.json
  def new
    @explorer = Explorer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @explorer }
    end
  end

  # GET /explorers/1/edit
  def edit
    @explorer = Explorer.find(params[:id])
  end

  # POST /explorers
  # POST /explorers.json
  def create
    # @explorer = Explorer.new(params[:explorer])
    @header=""
    @body=""
    @request=""
        
    @user_id = params[:explorer][:user_id]
    @url = params[:explorer][:apiurl]
    @method = params[:explorer][:apimethod]
    @auth = params[:explorer][:authentication]

    curl = Curl::Easy.new(@url)

    sent_headers = []
    curl.on_debug do |type, data|
      # track request headers
      sent_headers << data if type == Curl::CURLINFO_HEADER_OUT
    end

    curl.follow_location = true if params[:explorer][:follow_redirects]

    # ensure a method is set
    @method = (@method.to_s.empty? ? 'GET' : @method).upcase

    # update auth
    add_auth(@auth, curl, params[:explorer])

    # arbitrary headers
    add_headers_from_arrays(curl, params["header-keys"], params["header-vals"])

    # arbitrary post params
    if !params[:explorer]['post-body'].empty? && ['POST', 'PUT'].index(@method)
      @post_data = [params["explorer"]['post-body']]
    else
      @post_data = make_fields(@method, params["param-keys"], params["param-vals"])
    end
    
    # begin
      # debug { puts "#{@method} #{@url}" }
      # puts "#{@method} #{@url}"

      if @method == 'PUT'
        curl.http_put(stringify_data(@post_data))
      else
        curl.send("http_#{@method.downcase}", *@post_data)
      end

      @request = sent_headers.join("\n")
      @request << @post_data.join('&') if @post_data.any?
      @request = @request.gsub("\n", '<br/>')
      
      @header =  curl.header_str
      @header = @header.gsub("\n", '<br/>')
      @body = curl.body_str
      # @body = @body.gsub("\n", '<br/>')

      # @header  = pretty_print_headers(curl.header_str)
      # @type    = @url =~ /(\.js)$/ ? 'js' : curl.content_type
      # @body    = pretty_print(@type, curl.body_str)
      # @request = pretty_print_requests(sent_headers, post_data)
      
      # puts "request: " + @request
      # puts "header: " + @header
      # puts "body: " + @body

      # json :header    => @header,
      #      :body      => @body,
      #      :request   => @request,
      #      :hurl_id   => save_hurl(params),
      #      :prev_hurl => @user ? @user.second_to_last_hurl_id : nil,
      #      :view_id   => save_view(@header, @body, @request)
    # rescue => e
    #   # json :error => e.to_s
    # end

    respond_to do |format|
      if true #@explorer.save
        format.html { redirect_to @explorer, notice: 'Explorer was successfully created.' }
        format.json { render json: @explorer, status: :created, location: @explorer }
        format.js { render :action => 'create.js.coffee', :content_type => 'text/javascript'}
        # format.js 
        
      else
        format.html { render action: "new" }
        format.json { render json: @explorer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /explorers/1
  # PUT /explorers/1.json
  def update
    @explorer = Explorer.find(params[:id])

    respond_to do |format|
      if @explorer.update_attributes(params[:explorer])
        format.html { redirect_to @explorer, notice: 'Explorer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @explorer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /explorers/1
  # DELETE /explorers/1.json
  def destroy
    @explorer = Explorer.find(params[:id])
    @explorer.destroy

    respond_to do |format|
      format.html { redirect_to explorers_url }
      format.json { head :no_content }
    end
  end
  
  # update auth based on auth type
  def add_auth(auth, curl, params)
    if auth == 'Basic'
      username, password = params.values_at(:apiusername, :apipassword)
      encoded = Base64.encode64("#{username}:#{password}").gsub("\n",'')
      curl.headers['Authorization'] = "Basic #{encoded}"
    end
  end

  # headers from non-empty keys and values
  def add_headers_from_arrays(curl, keys, values)
    keys, values = Array(keys), Array(values)

    keys.each_with_index do |key, i|
      next if values[i].to_s.empty?
      curl.headers[key] = values[i]
    end
  end
  
  # post params from non-empty keys and values
  def make_fields(method, keys, values)
    return [] unless %w( POST PUT ).include? method

    fields = []
    keys, values = Array(keys), Array(values)
    keys.each_with_index do |name, i|
      value = values[i]
      next if name.to_s.empty? || value.to_s.empty?
      fields << Curl::PostField.content(name, value)
    end
    fields
  end
  
  # turn post_data into a string for PUT requests
  def stringify_data(data)
    if data.is_a? String
      data
    elsif data.is_a? Array
      data.map { |x| stringify_data(x) }.join("&")
    elsif data.is_a? Curl::PostField
      data.to_s
    else
      raise "Cannot stringify #{data.inspect}"
    end
  end
  
  
end
