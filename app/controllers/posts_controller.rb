class PostsController < ApplicationController
  # GET /posts
  include PostsHelper
  # GET /posts.json
  def index
    @posts = Post.all

    nyt("TOP")

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

      @account_sid = 'AC5c3158c9e08c18f1bd8674a5c9544b42'
      @account_token = '2804511ccef5b294daf82116c75a8f7d'
      @caller_id = '+15712978794'

      @post = Post.new(
        :from => @caller_id,
        :to => @to,
        :body => @body
        )  

      text = body.split(" ")
      if (text[0] == "NYT")
        textback = ''
        textback = nyt(text[1])
        puts "in the nyt loop"
        puts textback

      @client = Twilio::REST::Client.new(@account_sid, @account_token)
      response = @client.account.sms.messages.create( 
          :from => @caller_id,
          :to => @to,
          :body => textback )

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
