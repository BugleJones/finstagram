def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end

get '/' do
    post_bass = {
        username: "ItsMeFish",
        avatar_url: "http://www.taiwilliams.com/blog/wp-content/uploads/2014/08/tai-spike-august03-09.jpg",
        photo_url: "http://www.taiwilliams.com/blog/wp-content/uploads/2014/08/tai-spike-august03-09.jpg",
        humanized_time_ago: humanized_time_ago(10),
        like_count: 0,
        comment_count: 1,
        comments: [{
            username: "ItsMeFish",
            text: "Just got back from school lol"
        }]
    }
   
    post_catfish = {
        username: "Whiskers4Days",
        avatar_url: "https://1source.basspro.com/images/Catfish%20in%20dark%20waters.jpg",
        photo_url: "https://1source.basspro.com/images/Catfish%20in%20dark%20waters.jpg",
        humanized_time_ago: humanized_time_ago(4),
        like_count: 2,
        comment_count: 1,
        comments: [{
            username: "Whiskers4Days",
            text: "Suns out guns out"
        }]
    }
    
     post_drawings = {
        username: "HopelessFlounderer",
        avatar_url: "http://www.how-to-draw-cartoons-online.com/image-files/cartoon-catfish-6.gif",
        photo_url: "http://www.how-to-draw-cartoons-online.com/image-files/cartoon-catfish-6.gif",
        humanized_time_ago: humanized_time_ago(10),
        like_count: 134,
        comment_count: 1,
        comments: [{
            username: "HopelessFlounderer",
            text: "Credit to ArtFish, looks just like me #smile"
        }]
    }
    
    [post_bass, post_catfish, post_drawings].to_s
end