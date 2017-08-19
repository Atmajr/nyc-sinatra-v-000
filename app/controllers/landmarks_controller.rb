class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/edit'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed].to_i)
    redirect to "/landmarks/#{@landmark.id}"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])

    if ((@landmark.name != params[:landmark][:name]) && (params[:landmark][:name] != nil))
      @landmark.name = params[:landmark][:name]
    end

    if ((@landmark.year_completed != params[:landmark][:year_completed]) && (params[:landmark][:year_completed] != nil))
      @landmark.year_completed = params[:landmark][:year_completed]
    end

    @landmark.save

    redirect to "landmarks/#{@landmark.id}"

  end

end
