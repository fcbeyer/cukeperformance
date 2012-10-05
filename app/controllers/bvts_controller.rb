require 'C:/local/projects/Git/CukePerformance/BVT/jsonParse.rb'

class BvtsController < ApplicationController
  # GET /bvts
  # GET /bvts.json
  
  #runs script to grab build data from json dump
  #then manually create entries in the Bvt model each new one
  def auto_create
  	lastBvt = Bvt.last
  	build_stamp = lastBvt.build_date + "_" + lastBvt.build_time
  	@haveNewData = false
  	@build_list = getBuildList("BVT",build_stamp)
  	if @build_list.empty?
  		@haveNewBVTData = false
  	else
  		@haveNewBVTData = true
  		@build_list.each do |build|
	  		@bvt = Bvt.new
	  		@bvt.build_date = build.date
	  		@bvt.build_time = build.time
	  		@bvt.duration = build.duration
	  		@bvt.duration_converted = build.convertedDuration
	  		@bvt.save
  		end
  	end
  end
  
  def performance
		@buildData = Array.new
		categories = ["Build Date","Duration"]
		@buildData.push(categories)
		@build_list = Bvt.all
		@build_list.each do |bvt_build|
			@buildData.push(build_bvt_bar(bvt_build))
		end
		puts @buildData.to_s
  end
  
  def build_bvt_bar(bvt_build)
  	entry = Array.new
  	fullName = bvt_build.build_date + "_" + bvt_build.build_time
  	entry.push(fullName)
  	entry.push(bvt_build.duration)
  	return entry
  end
  
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
