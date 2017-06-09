def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end

get '/' do
    @posts = Post.order(created_at: :desc)
    erb(:index)
end

get "/signup" do     # if a user navigates to the path "/signup"
    @user = User.new # setup empty @user object
    erb(:signup)     # render "app/views/signups.erb"
end

post "/signup" do
    
    # grab user input values from params
    email      = params[:email]
    avatar_url = params[:avatar_url]
    username   = params[:username]
    password   = params[:password]
    
    # instantiate a user
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
    # if user validations pass and user is saved
    if @user.save
        # return readable representation of the object
        "User #{username} saved!"
    else
        #display error messages
        erb(:signup)
    end
end

#require Are you a fish checkbox?