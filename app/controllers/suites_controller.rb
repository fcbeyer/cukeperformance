require_relative '../../BVT/jsonParse.rb'

class SuitesController < ApplicationController
	
	#runs script to grab build data from json dump
  #then manually create entries in the Bvt model each new one
  def auto_create
  	lastSuite = Suite.last
  	if !lastSuite.nil?
  		build_stamp = lastSuite.build_date + "_" + lastSuite.build_time
  	else
  		build_stamp = "empty"
  	end
  	@haveNewSuiteData = false
  	@build_list = getBuildList("BVT",build_stamp)
  	if @build_list.empty?
  		@haveNewSuiteData = false
  	else
  		@haveNewSuiteData = true
  		@build_list.each do |build|
	  		@newSuite = Suite.new
	  		@newSuite.build_date = build.date
	  		@newSuite.build_time = build.time
	  		@newSuite.duration = build.duration
	  		@newSuite.duration_converted = build.convertedDuration
	  		@newSuite.name = "BuildVerificationTest"
	  		@newSuite.save
	  		build.features.each do |feature|
	  		  @newFeat = Feature.new
  		    @newFeat.keyword = feature.keyword
  		    @newFeat.name = feature.name
  		    @newFeat.duration = feature.duration
  		    @newFeat.duration_converted = feature.convertedDuration
  		    @newFeat.suite_id = @newSuite.id
	  		  @newFeat.save
	  		end
  		end #end build
  	end #end else
  end #end auto_create
  
  def performance_bvt
		@bvtData = Array.new
		categories = ["Build Date","Duration"]
		@bvtData.push(categories)
		@bvtBuilds = Suite.all
		@bvtBuilds.each do |bvt|
			@bvtData.push(build_bvt_bar(bvt))
		end
  end
  
  def build_bvt_bar(bvt)
  	entry = Array.new
  	entry.push(bvt.getFullName(bvt.id))
  	entry.push(bvt.duration)
  	return entry
  end
  
  
  # GET /suites
  # GET /suites.json
  def index
    @suites = Suite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suites }
    end
  end

  # GET /suites/1
  # GET /suites/1.json
  def show
    @suite = Suite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suite }
    end
  end

  # GET /suites/new
  # GET /suites/new.json
  def new
    @suite = Suite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suite }
    end
  end

  # GET /suites/1/edit
  def edit
    @suite = Suite.find(params[:id])
  end

  # POST /suites
  # POST /suites.json
  def create
    @suite = Suite.new(params[:suite])

    respond_to do |format|
      if @suite.save
        format.html { redirect_to @suite, notice: 'Suite was successfully created.' }
        format.json { render json: @suite, status: :created, location: @suite }
      else
        format.html { render action: "new" }
        format.json { render json: @suite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suites/1
  # PUT /suites/1.json
  def update
    @suite = Suite.find(params[:id])

    respond_to do |format|
      if @suite.update_attributes(params[:suite])
        format.html { redirect_to @suite, notice: 'Suite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suites/1
  # DELETE /suites/1.json
  def destroy
    @suite = Suite.find(params[:id])
    @suite.destroy

    respond_to do |format|
      format.html { redirect_to suites_url }
      format.json { head :no_content }
    end
  end
end
