require_relative '../performance/jsonParse.rb'

class SuitesController < ApplicationController
	
	include TaskAlertsHelper
	
	#runs script to grab build data from json dump
  #then manually create entries in the jobname model each new one
  def auto_create
  	task = Task.where(name: params[:jobname]).first
  	@haveNewSuiteData = false
		lastSuite = Suite.where(name: task.name).last
  	if !lastSuite.nil?
  		build_stamp = lastSuite.build_date + "_" + lastSuite.build_time
  	else
  		build_stamp = "empty"
  	end
		build_list = getBuildList(task.file_path,build_stamp)
		if build_list.kind_of?(FalseClass)
			@haveNewSuiteData = false
			@directoryDoesNotExist = true
  	elsif build_list.empty?
  		@haveNewSuiteData = false
  	else
  		@haveNewSuiteData = true
  		build_list.each do |build|
	  		newSuite = Suite.new
	  		newSuite.build_date = build.date
	  		newSuite.build_time = build.time
	  		newSuite.runstamp = build.runstamp
	  		newSuite.duration = build.duration
	  		newSuite.duration_converted = build.convertedDuration
	  		newSuite.browser = build.browser
	  		newSuite.os = build.os
	  		newSuite.mobilizer = build.mobilizer
	  		newSuite.mobilizer_build_tag = build.mobilizer_build_tag
	  		newSuite.url = build.url
	  		newSuite.name = task.name
	  		newSuite.status = build.status
	  		newSuite.save
	  		build.features.each do |feature|
	  		  newFeat = Feature.new
  		    newFeat.keyword = feature.keyword
  		    newFeat.name = feature.name
  		    newFeat.duration = feature.duration
  		    newFeat.duration_converted = feature.convertedDuration
  		    newFeat.suite_id = newSuite.id
  		    newFeat.status = feature.status
	  		  newFeat.save
	  		  feature.scenarios.each do |scenario|
	  		  	newScenario = Scenario.new
	  		  	newScenario.keyword = scenario.keyword
  		    	newScenario.name = scenario.name
  		    	newScenario.duration = scenario.duration
  		    	newScenario.duration_converted = scenario.convertedDuration
  		    	newScenario.feature_id = newFeat.id
  		    	newScenario.status = scenario.status
	  		  	newScenario.save
	  		  	scenario.steps.each do |step|
	  		  		newStep = Step.new
	  		  		newStep.keyword = step.keyword
  		    		newStep.name = step.name
  		    		newStep.duration = step.duration
  		    		newStep.duration_converted = step.convertedDuration
  		    		newStep.status = step.status
  		    		newStep.scenario_id = newScenario.id
  		    		newStep.status = step.status
  		    		newStep.reason_for_failure = step.reason_for_failure
							newStep.failure_image = step.failure_image
	  		  		newStep.save
	  		  	end #end step
	  		  end #end scenario
	  		end #end feature
  		end #end build
  	end #end else
  	check_all_alerts(task)
  end #end auto_create
  
  # GET /suites
  # GET /suites.json
  def index
  	  	
    @suites = {}
    @suite_list.each do |entry|
    	@suites[entry.name] = Suite.order("runstamp desc").where(name: entry.name)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suites }
    end
  end

  # GET /suites/1
  # GET /suites/1.json
  def show
    @current_suite = Suite.find(params[:id])

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
