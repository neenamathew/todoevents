class TodoeventsController < ApplicationController

  respond_to :html, :js
  before_action :all_tasks, only: [:index, :create, :update]
  before_action :set_todoevent, only: [:edit, :destroy]

  def index
    @todoevents = Todoevent.all.order('created_at ASC')
  end

  def indeindex
    @todoevents = Todoevent.filter(params[:search]).order('created_at DESC')
    @todoevent = Todoevent.new
    @display_events = Hash.new
    @display_events = @todoevents.order('created_at DESC').to_a.group_by { |event| event.status_check(event) }
    if @display_events.has_key?("active") then @display_events["active"] = @display_events["active"] end
    if @display_events.has_key?("completed") then @display_events["completed"] = @display_events["completed"] end
  end


  def show
    @todoevent = Todoevent.find(params[:id])
  end

  def new
    @todoevents = Todoevent.all.order('created_at ASC')
    @todoevent = Todoevent.new
    @display_events = Hash.new
    @display_events = @todoevents.order('created_at DESC').to_a.group_by { |event| event.status_check(event) }
    if @display_events.has_key?("active") then @display_events["active"] = @display_events["active"] end
    @todoevent = Todoevent.new
  end

  def edit
    @todoevent = Todoevent.find(params[:id])
  end

  def create
    # binding.pry
    @todoevent = Todoevent.create(name: params[:name])
    respond_to do |format|
      format.js
    end
  end

  def update
    @todoevent = Todoevent.find(params[:id])
    @todoevent.name = params[:name]
    @todoevent.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @todoevent.destroy
    @todoevents =  Todoevent.all.order('created_at ASC')
    respond_to do |format|
      format.js
    end
  end

  def complete
    todoevent = Todoevent.find_by_id(params[:id])
    todoevent.update_attribute(:status, "completed")
    @todoevents =  Todoevent.all.order('created_at ASC')
    respond_to do |format|
      format.js
    end
  end

  def complete_all
    Todoevent.all.each do|todoevent|
      todoevent.update_attribute(:status, "completed")
    end
    @todoevents =  Todoevent.all.order('created_at ASC')
    respond_to do |format|
      format.js
    end
  end

  def unmark
    todoevent = Todoevent.find_by_id(params[:id])
    todoevent.update_attribute(:status, "active")
    respond_to do |format|
      format.js
    end
  end

  def add
    Todoevent.new(:name => params[:name]).save
    redirect_to :action => 'index'
  end

  def status_order
    if params[:status] == "all"
      @todoevents =  Todoevent.all.order('created_at ASC')
    else
      @todoevents = Todoevent.where('status IN (?)',params[:status])
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy_completed
    todoevents = Todoevent.where('status IN (?)',"completed")
    todoevents.destroy_all
    @todoevents =  Todoevent.all.order('created_at ASC')
    respond_to do |format|
      format.js
    end
  end

  private

  def all_tasks
    @todoevents =  Todoevent.all.order('created_at ASC')
  end

  def set_todoevent
    @todoevent = Todoevent.find(params[:id])
  end

  def todoevent_params
    params.require(:todoevent).permit(:name)
  end
end
