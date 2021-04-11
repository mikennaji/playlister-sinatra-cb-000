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

  post '/new_songs' do
   @song = Song.create(name: params[:Name])
   @artist = Artist.find_by(name: params["Artist Name"])
   if @artist
     @song.artist = @artist
   else
     @aritst = Artist.create(name: params["Artist Name"])



  end
  params[:genres].each do |genre|
  @genre = Genre.find_by(name: genre)
    if @genre
      SongGenre.create(song: @song, genre: @genre)
    else
      @genre = Genre.create(name: genre)
     SongGenre.create(song: @song, genre: @genre)
   end
 end
 @song.save
 redirect to "/songs/#{@song.slug}"
 end

 get '/songs/:slug' do
   @song = Song.slug(params[:slug])
   erb :'/songs/show'
 end

end
