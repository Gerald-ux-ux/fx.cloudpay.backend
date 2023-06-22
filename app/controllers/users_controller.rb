class UsersController < ApplicationController
  wrap_parameters format: []

  def index
  users = User.all.map do |user|
    {
      id: user.id,
      email: user.email,
      name: user.name,
      password_digest: user.password_digest,
      created_at: user.created_at.strftime("%d/%m/%Y"),
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
  params.require(:user).permit(:name, :email, :password)
  end

end
