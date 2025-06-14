class Api::GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :update, :destroy]

  # GET /goals
  def index
    @goals = current_user.goals
    if params[:filter].present?
      @goals = @goals.where(credit_card_id: params[:filter][:credit_card_id]) if params[:filter][:credit_card_id].present?
    end

    render json: @goals, each_serializer: GoalSerializer
  end

  # GET /goals/:id
  def show
    render json: @goal, serializer: GoalSerializer
  end

  # POST /goals/:id
  def create
    @goal = Goal.new(goal_params.merge(user_id: current_user.id))
    if @goal.save
      render json: @goal, serializer: GoalSerializer, status: :created
    else
      render json: ErrorSerializer.serialize(@goal.errors), status: :unprocessable_entity
    end
  end

  # PUT/PATCH /goals/:id
  def update
    if @goal.update(goal_params.merge(user_id: current_user.id))
      render json: @goal, serializer: GoalSerializer
    else
      render json: ErrorSerializer.serialize(@goal.errors), status: :unprocessable_entity
    end
  end

  # DELETE /goals/:id
  def destroy
    @goal.destroy
    head :no_content
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Transação não encontrada' }, status: :not_found
  end

  def goal_params
    params.require(:goal).permit(:name, :target_amount, :current_amount, :target_date)
  end
end
