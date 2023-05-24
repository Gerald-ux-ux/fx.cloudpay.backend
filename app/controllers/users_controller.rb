class UsersController < ApplicationController
  wrap_parameters format: []

  def index
    render json: User.all, status: :ok
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
    user.formatted_date = Time.now.strftime("%b %d %Y")

    if user.save
      render json: user, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

    def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
   end

  private

  def user_params
    params.permit(:email, :password)
  end

end
