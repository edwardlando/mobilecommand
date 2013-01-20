class PostsController < ApplicationController
  # GET /posts
  include PostsHelper
  # GET /posts.json
  def index
    @posts = Post.all

#    string = "3401 walknut street philadelphia,pa | 3601 chestnut street philadelphia,pa"
#    google_maps_pic(string,"+12567972518")
    #send_message(duckduckgo("groom"),"+12567972518")
    from = "+12567972518"
    origin = "3401 chestnut st philadelphia"
    dest = "3601 walnut st philadelphia"
    puts get_directions(origin,dest,from)
 #   send_message(get_directions(origin,dest,from),from)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new()
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    nyt("TOP")
  end

  # POST /posts
  # POST /posts.json
  def create
    if request.post?

      @to = params[:From] ||= params[:post][:from]
      @body = params[:Body] ||= params[:post][:body]

      @post = Post.new(
        :from => @caller_id,
        :to => @to,
        :body => @body
        )  
      @body.upcase!
      text = @body.split(" ")
      if (text[0] == "NYT")
        textback = ''
        textback = nyt(text[1])
        puts "in the nyt loop"
        puts textback
        send_message(textback,@to)
      elsif (text[0] == "ESPN")
        textback = ''
        textback = espn(text[1])
        send_message(textback,@to)
      elsif (text[0] == "MAP")
        places = text[3..-1]
        pl_arr = places.split("|")
        msg = get_directions(pl_arr[0],pl_arr[1],@to)
        puts msg
        send_message(msg,@to)
       # google_maps_pic(@body[3..-1])
      elsif (text[0] == "DDG")
        send_message(duckduckgo(text[1]),@to)
      elsif (text[0] == "EBAY")
        textback = ''

        keywords = ''
        text.each_with_index do |thing,ind|
          if (keywords == '')
            keywords = thing
          else 
            keywords = keywords + ' ' + thing
          end
        end

        textback = ebay(text[1], keywords) #second and third
        send_message(textback,@to)
      end

      @post.save 

      render 'index'
    end
  end


  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
