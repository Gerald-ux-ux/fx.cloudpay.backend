class CollectionsController < ApplicationController
  def index
    if params[:date].present?
      selected_date = Date.parse(params[:date])
      userId = params[:user_id]
      collections = Collection.where(date: selected_date,user_id:userId)
      if collections.empty?
              render json: { error: "No Collections found for the specified date" }, status: :not_found
      else
          render json: collections, status: :ok
      end

    else
      render json: { error: "no collections were added on this date" }, status: :bad_request
    end
  end

  def create
    user = User.find(params[:collection][:user_id])
    collection = user.collections.build(collection_params)
    collection.date = Date.current
    collection.formatted_date = collection.date.strftime("%Y-%m-%d")

    if collection.save
      render json: collection_with_user(collection), status: :created
    else
      render json: { error: collection.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:user_id, :amount, :name)
  end

  def collection_with_user(collection)
    {
      id: collection.id,
      name: collection.name,
      amount: collection.amount,
      date: collection.date,
      created_at: collection.created_at,
      updated_at: collection.updated_at,
      formatted_date: collection.formatted_date,
      user_id: collection.user.id,
      user: {
        id: collection.user.id,
        email: collection.user.email
      }
    }
  end
end
