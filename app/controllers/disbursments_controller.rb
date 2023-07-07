class DisbursmentsController < ApplicationController
  def index
    if params[:date].present?
      selected_date = Date.parse(params[:date])
      userId = params[:user_id];
      disbursments = Disbursment.where(date: selected_date,user_id:userId)
      if disbursments.empty?
        render json: { error: "No Disbursements found for the specified date" }, status: :not_found
      else
        render json: disbursments, status: :ok
      end
    else
      render json: { error: "No date specified" }, status: :bad_request
    end
  end

  def create
    user = User.find(params[:user_id]) # Updated to use disbursment_params
    disbursment = user.disbursments.build(disbursment_params) # Updated to use disbursment_params
    disbursment.date = Date.current
    disbursment.formatted_date = disbursment.date.strftime("%Y-%m-%d")

    if disbursment.save
      render json: disbursment_with_user(disbursment), status: :created
    else
      render json: { error: disbursment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

def disbursment_params
  params.require(:disbursment).permit(:disbursment)
end

  def disbursment_with_user(disbursment) # Corrected the method name
    {
      id: disbursment.id,
       amount: disbursment.disbursment, # Update the attribute name to 'disbursment'
      date: disbursment.date,
      created_at: disbursment.created_at,
      updated_at: disbursment.updated_at,
      formatted_date: disbursment.formatted_date,
      user_id: disbursment.user.id,
      user: {
        id: disbursment.user.id,
        email: disbursment.user.email
      }
    }
  end
end
