class PostsController < ApplicationController
  # GET /posts
  include PostsHelper
  # GET /posts.json
  def index
    @posts = Post.all

    send_message("hello tanvir","+15612071086")

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

      @preserved_body = @body.clone
      @body.upcase!

      preserved_text = @preserved_body.split(" ")
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
      elsif (text[0] == "EBAY")
        textback = ''

        keywords = ''
        preserved_keywords  = ''
        text.each.with_index do |thing, idx|
          if (idx > 1)
            if (keywords == '')
              keywords = thing
            else 
              keywords = keywords + ' ' + thing
            end
          end
        end

        preserved_text.each.with_index do |thing, idx|
          if (idx > 1)
            if (preserved_keywords == '')
              preserved_keywords = thing
            else 
              preserved_keywords = preserved_keywords + ' ' + thing
            end
          end
        end

        textback = ebay(text[1], keywords, preserved_keywords) #second and third
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
