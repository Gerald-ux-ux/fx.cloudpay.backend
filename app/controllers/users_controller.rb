class UsersController < ApplicationController
  wrap_parameters format: []

 def index
  users = User.all.map do |user|
    {
      id: user.id,
      email: user.email,
      name: user.name,
      created_at: user.created_at.strftime("%Y-%m-%d"),
    }
  end
  render json: users, status: :ok
end



  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

def create
  user = User.new(user_params)
  user.formatted_date = Time.now.strftime("%Y-%m-%d")

  if user.save
    render json: user, status: :created
  else
    render json: { error: user.errors.full_messages }, status: :unprocessable_entity
  end
end


    def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { data: user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
   end

  private

def user_params
  params.require(:user).permit(:name, :email, :password)
end

end
