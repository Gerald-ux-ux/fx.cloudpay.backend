class BalancesController < ApplicationController
     wrap_parameters format: []
 def create
    user = User.find(params[:balance][:user_id])
    balance = user.balances.build(balance_params)
    balance.date = Date.current
    balance.formatted_date = balance.date.strftime("%b %d %Y")

    if balance.save
      render json: balance_with_user(balance), status: :created
    else
      render json: { error: balance.errors.full_messages }, status: :unprocessable_entity
    end
  end

def index
  if params[:date].present?
    selected_date = Date.parse(params[:date])
    balances = Balance.where(formatted_date: selected_date.strftime("%b %d %Y"))

    if balances.empty?
      render json: { error: "No balances found for the specified date" }, status: :not_found
    else
      render json: balances, status: :ok
    end
  else
    render json: { error: "No date specified" }, status: :bad_request
  end
end


private
def balance_params
  params.require(:balance).permit(:user_id, :amount)
end


  def balance_with_user(balance)
    {
      id: balance.id,
      amount: balance.amount,
      date: balance.date,
      created_at: balance.created_at,
      updated_at: balance.updated_at,
      formatted_date: balance.formatted_date,
      user_id: balance.user.id,
      user: {
        id: balance.user.id,
        email: balance.user.email
      }
    }
  end
end
