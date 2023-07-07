class OpeningsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    opening = user.openings.build(opening_params)
    opening.date = Date.current
    opening.formatted_date = opening.date.strftime("%Y-%m-%d")

    if opening.save
      render json: opening_with_user(opening), status: :created
    else
      render json: { error: opening.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
  if params[:date].present?
    selected_date = Date.parse(params[:date])
    userId = params[:user_id];
    openings = Opening.where(formatted_date: selected_date.strftime("%Y-%m-%d"),user_id: userId)

    if  openings.empty?
      render json: { error: "No balances found for the specified date" }, status: :not_found
    else
      render json:  openings, status: :ok
    end
  else
    render json: { error: "No date specified" }, status: :bad_request
  end
end

def destroy
  formatted_date = Date.parse(params[:date]).strftime("%Y-%m-%d")
  Opening.where(formatted_date: formatted_date).destroy_all

  head :no_content
end



  private

  def opening_params
    params.require(:opening).permit(:user_id, :amount)
  end

  def opening_with_user(opening)
    {
      id: opening.id,
      amount: opening.amount,
      date: opening.date,
      created_at: opening.created_at,
      updated_at: opening.updated_at,
      formatted_date: opening.formatted_date,
      user_id: opening.user.id,
      user: {
        id: opening.user.id,
        email: opening.user.email
      }
    }
  end
end
