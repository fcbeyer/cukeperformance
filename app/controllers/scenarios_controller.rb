class ScenariosController < ApplicationController
  # GET /scenarios
  # GET /scenarios.json
  
  before_filter :get_suite_and_feature
  
  def get_suite_and_feature
    @current_suite = Suite.find(params[:suite_id])
    @current_feature = Feature.find(params[:feature_id])
  end
  
  def index
    @scenarios = @current_feature.scenarios

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scenarios }
    end
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    @current_scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scenario }
    end
  end

  # GET /scenarios/new
  # GET /scenarios/new.json
  def new
    @scenario = Scenario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scenario }
    end
  end

  # GET /scenarios/1/edit
  def edit
    @scenario = Scenario.find(params[:id])
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = Scenario.new(params[:scenario])
    @scenario.feature_id = params[:feature_id]

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to [@current_suite, @current_feature, @scenario], notice: 'Scenario was successfully created.' }
        format.json { render json: @scenario, status: :created, location: @scenario }
      else
        format.html { render action: "new" }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scenarios/1
  # PUT /scenarios/1.json
  def update
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      if @scenario.update_attributes(params[:scenario])
        format.html { redirect_to [@current_suite, @current_feature, @scenario], notice: 'Scenario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario = Scenario.find(params[:id])
    @scenario.destroy

    respond_to do |format|
      format.html { redirect_to scenarios_url }
      format.json { head :no_content }
    end
  end
end
