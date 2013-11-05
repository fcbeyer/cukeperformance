class SuitesController < ApplicationController
	
	include TaskAlertsHelper
	
	#runs script to grab build data from json dump
  #then manually create entries in the jobname model each new one
  def auto_create
  	task = Task.where(name: params[:jobname]).first
  	capture_results = []
  	send_email = params[:send_email].nil? ? true : false
  	@haveNewSuiteData = false
		lastSuite = Suite.where(name: task.name).last
		problem = false
  	if !lastSuite.nil?
  		build_stamp = lastSuite.build_date + "_" + lastSuite.build_time
  	else
  		build_stamp = "empty"
  	end
  	begin
			build_list = CukeParser.json_jenkins_list(task.file_path,build_stamp)
		rescue Exception
			STDERR.puts "AHHH THIS IS AWFUL! #{$!}"
			problem = true
			build_list = false
		end
		if build_list.kind_of?(FalseClass)
			@haveNewSuiteData = false
			@directoryDoesNotExist = true
  	elsif build_list.empty?
  		@haveNewSuiteData = false
  	else
  		@haveNewSuiteData = true
  		build_list.each do |cuke_results|
  			suite = Suite.new({:build_date => cuke_results.date,:build_time => cuke_results.time,:runstamp => cuke_results.runstamp,:duration => cuke_results.duration,
						:duration_converted => cuke_results.converted_duration,:browser => cuke_results.browser,:os => cuke_results.os,:mobilizer => cuke_results.branch_number,
						:mobilizer_build_tag => cuke_results.branch_build_tag,:url => cuke_results.url,:name => task.name,:status => cuke_results.status,:exclude => false})
				suite.save
				cuke_results.features.each do |cur_feature|
					#save each feature
					feature = Feature.new({:keyword => cur_feature.keyword,:name => cur_feature.name,:duration => cur_feature.duration,
											:duration_converted => cur_feature.converted_duration,:suite_id => suite.id,:status => cur_feature.status})
					feature.save
					cur_feature.scenarios.each do |cur_scenario|
						#save each scenario
						scenario = Scenario.new({:keyword => cur_scenario.keyword,:name => cur_scenario.name,:duration => cur_scenario.duration,
												:duration_converted => cur_scenario.converted_duration,:feature_id => feature.id,:status => cur_scenario.status})
						scenario.save
						cur_scenario.steps.each do |cur_step|
							#save each step
							step = Step.new({:keyword => cur_step.keyword,:name => cur_step.name,:duration => cur_step.duration,:duration_converted => cur_step.converted_duration,
											:status => cur_step.status,:scenario_id => scenario.id,:reason_for_failure => cur_step.reason_for_failure,:failure_image => cur_step.failure_image})
							step.save
						end #end steps
					end #end scenarios
				end #end features
			end #end build_list
  	end #end else
  	check_task_alerts(task,send_email)
  	capture_results.push(@haveNewSuiteData)
  	capture_results.push(@directoryDoesNotExist)
  	capture_results.push(task.display_name)
  	capture_results.push(problem)
  	
  	respond_to do |format|
			format.json {render json: capture_results}
			format.html {render html: capture_results}
  	end
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
