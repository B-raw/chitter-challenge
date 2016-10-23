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
    erb(:'peeps/new')
  end

  post '/peeps' do
    current_user.peeps << Peep.create(content: params[:content])
    current_user.save
    redirect '/peeps'
  end


end
