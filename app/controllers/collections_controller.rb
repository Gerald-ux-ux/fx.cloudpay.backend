class CollectionsController < ApplicationController
def index
    if params[:date].present?
        selected_date = Date.parse(params[:date])
        collections = Collection.where(date: selected_date)
        render json: collections, status: :ok
     else
        render json: {error: "no collections were added on this date"}, status: :bad_request
     end
    end
end

end
