class RatesController < ApplicationController
  def create
    user = User.find(params[:user_id])
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
    selected_date = Date.parse(params[:date])
    userId = params[:user_id]
    rates = Rate.where(formatted_date: selected_date.strftime("%b %d %Y"),user_id: userId)

    if  rates.empty?
      render json: { error: "No balances found for the specified date" }, status: :not_found
    else
      render json:  rates, status: :ok
    end
  else
    render json: { error: "No date specified" }, status: :bad_request
  end
end

def destroy
  formatted_date = Date.parse(params[:date]).strftime("%b %d %Y")
  Rate.where(formatted_date: formatted_date).destroy_all

  head :no_content
end

  private

  def rate_params
    params.require(:rate).permit(:user_id, :amount)
  end

  def rate_with_user(rate)
    {
      id: rate.id,
      amount: rate.amount,
      rate: rate.amount,
      date: rate.formatted_date,
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
