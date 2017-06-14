helpers do 
    def current_user
        User.find_by(id: session[:user_id])
    end
end

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
    email      = params[:email]
    avatar_url = params[:avatar_url]
    username   = params[:username]
    password   = params[:password]
    
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
    
    if @user.save
        redirect to("/login")
    else
        erb(:signup)
    end
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

get "/login" do  # when a GET request comes into /login

    erb(:login)
    
end

post "/login" do
    username = params[:username] # username retrieve
    password = params[:password] # password retrieve
    
    # 1. find by username
    user = User.find_by(username: username)
    
    # 2. if that user exists
    if user && user.password == password
        session[:user_id] = user.id
        redirect to("/")
    else
        @error_message = "No fish found."
        erb(:login)
    end
end

get "/logout" do
    session[:user_id] = nil?
    redirect to ("/")
end

#require Are you a fish checkbox?