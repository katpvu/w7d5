class SubsController < ApplicationController
     before_action :current_user, :require_logged_in, only: [:edit, :update]


    

    def index
        if params[:user_id]
            @subs = Sub.where(id: params[:user_id])
            render :index
        else
            @subs = Sub.all 
            render :index
        end
    end

    def show
        @sub = Sub.find_by(id: params[:id])
        render :show
    
    end

    def new
        render :new
    end
    
    def create 
        @sub = Sub.new(
            title: params[:sub][:title],
            description: params[:sub][:description], 
            moderator_id: params[:user_id]
        )
        if @sub.save  
            redirect_to sub_url(@sub.id)
        else
            flash.now[:errors] = @subs.errors.full_messages
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

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
