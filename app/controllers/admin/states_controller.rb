class Admin::StatesController < ApplicationController

  def index
    @states = policy_scope(State)
    @states = State.all
    authorize State
  end

  def new
    @state = State.new
    authorize @state, :show?
  end

  def create
    @state = State.new(state_params)
    authorize @state, :create?
    if @state.save
      flash[:notice] = "State has been created."
      redirect_to admin_states_path
    else
      flash.now[:alert] = "State has not been created."
      render "new"
    end
  end

  def make_default
    @state = State.find(params[:id])
    @state.make_default!
    authorize @state, :show?
    flash[:notice] = "'#{@state.name}' is now the default state."
    redirect_to admin_states_path
  end

  private

  def state_params
    params.require(:state).permit(:name, :color)
  end
end
