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
    @user = User.new()
    erb(:signup)
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

get "/posts/new" do
    @post = Post.new
    erb(:"posts/new")
end

post "/posts" do
    photo_url = params[:photo_url]
    
    @post = Post.new({ photo_url: photo_url, user_id: current_user.id })
    
    if @post.save
        redirect(to("/"))
    else
        erb(:"posts/new")
    end
end

get "/posts/:id" do
    @post = Post.find(params[:id])
    erb(:"posts/show")
end

post "/comments" do
    text = params[:text]
    post_id = params[:post_id]
    
    comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id })
    
    comment.save
    
    redirect(back)
end

post "/likes" do
    post_id = params[:post_id]
    
    like = Like.new({ post_id: post_id, user_id: current_user.id })
    like.save
    
    redirect(back)
end

delete "/likes/:id" do
    like = Like.find(params[:id])
    like.destroy
    redirect (back)
end

#require Are you a fish checkbox?