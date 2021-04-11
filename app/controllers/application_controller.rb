class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

    post '/songs' do
       @song = Song.create(:name => params["Name"])
       @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
       @song.genre_ids = params[:genres]
       @song.save

       flash[:message] = "Successfully created song."

       redirect("/songs/#{@song.slug}")
     end

 get '/songs/:slug' do
   @song = Song.find_by_slug(params[:slug])
   erb :'/songs/show'
 end

end
