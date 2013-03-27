class TaskAlertsController < ApplicationController
  # GET /task_alerts
  # GET /task_alerts.json
  
  include TaskAlertsHelper
  
  before_filter :get_task
  
  def test_alert
  	alerts_triggered = []
  	if params[:alert].empty?
  		check_all_alerts(@current_task,false)
  	else
  		alert = TaskAlert.find(params[:alert])
  		alerts_triggered.push(check_alert(alert,false))
  	end
  	alerts_triggered.insert(0,@current_task.name)
  	respond_to do |format|
			format.json {render json: alerts_triggered}
			format.html {render html: alerts_triggered}
  	end
  end
  
  def get_task
  	@current_task = Task.find(params[:task_id])
  end
  
  def index
    @task_alerts = @current_task.task_alerts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_alerts }
    end
  end

  # GET /task_alerts/1
  # GET /task_alerts/1.json
  def show
    @task_alert = TaskAlert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_alert }
    end
  end

  # GET /task_alerts/new
  # GET /task_alerts/new.json
  def new
    @task_alert = TaskAlert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_alert }
    end
  end

  # GET /task_alerts/1/edit
  def edit
    @task_alert = TaskAlert.find(params[:id])
  end

  # POST /task_alerts
  # POST /task_alerts.json
  def create
    @task_alert = TaskAlert.new(params[:task_alert])
    @task_alert.task_id = params[:task_id]

    respond_to do |format|
      if @task_alert.save
        format.html { redirect_to [@current_task,@task_alert], notice: 'Task alert was successfully created.' }
        format.json { render json: @task_alert, status: :created, location: @task_alert }
      else
        format.html { render action: "new" }
        format.json { render json: @task_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_alerts/1
  # PUT /task_alerts/1.json
  def update
    @task_alert = TaskAlert.find(params[:id])

    respond_to do |format|
      if @task_alert.update_attributes(params[:task_alert])
        format.html { redirect_to [@current_task,@task_alert], notice: 'Task alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_alerts/1
  # DELETE /task_alerts/1.json
  def destroy
    @task_alert = TaskAlert.find(params[:id])
    @task_alert.destroy

    respond_to do |format|
      format.html { redirect_to task_task_alerts_url }
      format.json { head :no_content }
    end
  end
end
