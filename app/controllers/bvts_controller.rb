class BvtsController < ApplicationController
  # GET /bvts
  # GET /bvts.json
  def index
    @bvts = Bvt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bvts }
    end
  end

  # GET /bvts/1
  # GET /bvts/1.json
  def show
    @bvt = Bvt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bvt }
    end
  end

  # GET /bvts/new
  # GET /bvts/new.json
  def new
    @bvt = Bvt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bvt }
    end
  end

  # GET /bvts/1/edit
  def edit
    @bvt = Bvt.find(params[:id])
  end

  # POST /bvts
  # POST /bvts.json
  def create
    @bvt = Bvt.new(params[:bvt])

    respond_to do |format|
      if @bvt.save
        format.html { redirect_to @bvt, notice: 'Bvt was successfully created.' }
        format.json { render json: @bvt, status: :created, location: @bvt }
      else
        format.html { render action: "new" }
        format.json { render json: @bvt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bvts/1
  # PUT /bvts/1.json
  def update
    @bvt = Bvt.find(params[:id])

    respond_to do |format|
      if @bvt.update_attributes(params[:bvt])
        format.html { redirect_to @bvt, notice: 'Bvt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bvt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bvts/1
  # DELETE /bvts/1.json
  def destroy
    @bvt = Bvt.find(params[:id])
    @bvt.destroy

    respond_to do |format|
      format.html { redirect_to bvts_url }
      format.json { head :no_content }
    end
  end
end
