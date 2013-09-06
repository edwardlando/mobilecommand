class PastpostsController < ApplicationController
  # GET /pastposts
  # GET /pastposts.json
  def index
    @pastposts = Pastpost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pastposts }
    end
  end

  # GET /pastposts/1
  # GET /pastposts/1.json
  def show
    @pastpost = Pastpost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pastpost }
    end
  end

  # GET /pastposts/new
  # GET /pastposts/new.json
  def new
    @pastpost = Pastpost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pastpost }
    end
  end

  # GET /pastposts/1/edit
  def edit
    @pastpost = Pastpost.find(params[:id])
  end

  # POST /pastposts
  # POST /pastposts.json
  def create
    @pastpost = Pastpost.new(params[:pastpost])

    respond_to do |format|
      if @pastpost.save
        format.html { redirect_to @pastpost, notice: 'Pastpost was successfully created.' }
        format.json { render json: @pastpost, status: :created, location: @pastpost }
      else
        format.html { render action: "new" }
        format.json { render json: @pastpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pastposts/1
  # PUT /pastposts/1.json
  def update
    @pastpost = Pastpost.find(params[:id])

    respond_to do |format|
      if @pastpost.update_attributes(params[:pastpost])
        format.html { redirect_to @pastpost, notice: 'Pastpost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pastpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pastposts/1
  # DELETE /pastposts/1.json
  def destroy
    @pastpost = Pastpost.find(params[:id])
    @pastpost.destroy

    respond_to do |format|
      format.html { redirect_to pastposts_url }
      format.json { head :no_content }
    end
  end
end
