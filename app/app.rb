ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'data-mapper-setup'

require_relative 'server'
require_relative 'controllers/users'
require_relative 'controllers/sessions'

class Chitter < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/peeps' do
    erb(:'peeps')
  end

  get '/peeps/new' do
    if current_user
      erb(:'peeps/new')
    else
      flash.keep[:errors] = ["You need to be logged in to post a peep"]
      redirect '/sessions/new'
    end
  end

  post '/peeps' do
    time = Time.now
    current_user.peeps << Peep.create(content: params[:content],
                                      created_at: time)
    current_user.save
    redirect '/peeps'
  end


end
