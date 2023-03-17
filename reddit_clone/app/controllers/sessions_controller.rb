class SessionsController < ApplicationController
    #rendering a log in page
    def new
        render :new
        #take in username and password
    end

    #log in a user
    def create
        incoming_username = params[:user][:username] 
        incoming_password = params[:user][:password]
        params = { user: { username: "user_input", password: "user_input"} }
        @user = User.find_by_credentials(incoming_username, incoming_password)
        if @user 
            login(@user) #matching session tokens
            redirect_to user_url(@user)
        else #invalid credentials
            flash.now[:errors] = ["Invalid username or password"]
            render :new
        end
    end

    #log out a user
    def destroy
        logout
        redirect_to new_session_url
    end

end

#every request has path, HTTP verb, params (wildcard, query string(k-v pairs), data(k-v pairs))
# form action=kfjskfd, method="post"
# input --> username
# input --> password
# params = { user: { username: "user_input", password: "user_input"} }