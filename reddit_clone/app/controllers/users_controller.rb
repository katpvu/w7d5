class UsersController < ApplicationController

    #actions and strong params

    #render a page that shows all the users
    def index
    end

    #renders a page that shows the User's page
    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    #render the sign up page
    def new
        render :new
    end

    #create a user and save it into the database
    #if there are errors, render the errors and also render new sign up page
    def create
        @user = User.new(user_params)
        if @user.save #passed all model and DB validations
            redirect_to user_url(@user)
        else #errors: username is already taken, or password is too short
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
