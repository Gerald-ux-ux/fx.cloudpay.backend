class ClosingsController < ApplicationController

  def create
    user = User.find_by(params[:user_id])
    closing = user.closing.build(closing_params)
    closing.date = Date.current
    closing.formatted_date  = collection.date.strftime("%Y-%m-%d")

    if closing.save
      render json: closing_with_user(closing), status: :created
    else
      render json: { error: closing.errors.full_messages }, status: :unprocessable_entity
    end

  end


  def index
    if params[:date].present?
      selected_date = Date.parse(params[:date])
      userId = params[:user_id]
      closing = Closing.where(formatted_date: selected_date.strftime.strftime("%Y-%m-%d"),user_id: userId)

      if collection.empty?
        render json: { error: "No closing balance remained yesterday" }
      else
        render json: closing, status: :ok
      end
    else
      render json: { error: "No date specified"} status: :bad_request
    end
  end

  private

  def closing_params
    params.require(:closing).permit(:user_id, :amount)
  end

  def closing_with_user(closing)
    {
      id: closing.id,
      amount: closing.amount,
      date: closing.date,
      created_at: closing.created_at,
      updated_at: closing.updated_at,
      formatted_date: closing.formatted_date,
      user_id: closing.user.id,
      user: {
        id: closing.user.id,
        email: closing.user.email
      }
    }

  end


end
