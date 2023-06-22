class RatesController < ApplicationController
  def create
    user = User.find(params[:rate][:user_id])
    rate = user.rates.build(rate_params)
    rate.date = Date.current
    rate.formatted_date = rate.date.strftime("%b %d %Y")

    if rate.save
      render json: rate_with_user(rate), status: :created
    else
      render json: { error: rate.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
  if params[:date].present?
    selected_date = Date.parse(params[:date]) rescue nil

    if selected_date.nil?
      render json: { error: "Invalid date format" }, status: :unprocessable_entity
    else
      rates = Rate.where(date: selected_date)

      if rates.empty?
        render json: { error: "No rates found for the specified date" }, status: :not_found
      else
        render json: rates, status: :ok
      end
    end
  else
    render json: { error: "No date specified" }, status: :bad_request
  end
end


  private

  def rate_params
    params.require(:rate).permit(:user_id, :amount)
  end

  def rate_with_user(rate)
    {
      id: rate.id,
      amount: rate.amount,
      date: rate.date,
      created_at: rate.created_at,
      updated_at: rate.updated_at,
      formatted_date: rate.formatted_date,
      user_id: rate.user.id,
      user: {
        id: rate.user.id,
        email: rate.user.email
      }
    }
  end
end
