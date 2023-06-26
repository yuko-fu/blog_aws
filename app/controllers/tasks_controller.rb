class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    if params[:task].present?
      if  @task = Task.where
      elsif @task = Task.where('task_name like ?', params[:task])
      elsif @task = Task.where(status, params[:status])
    end
    @tasks = Task.all.order(created_at: "DESC")
    if params[:sort_end].present?
      @tasks = Task.order(end_date: :asc)
    end
    render :index
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:task_name, :content, :created_at, :end_date, :status)
    end
end
