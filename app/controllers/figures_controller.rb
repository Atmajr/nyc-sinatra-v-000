class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @titles = @figure.titles
    @landmarks = @figure.landmarks
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @figure_titles = @figure.titles
    @figure_landmarks = @figure.landmarks
    erb :'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if params[:title][:name] != nil
      puts 'New title entered'
      @title = Title.create(params[:title])
      @figure.titles << @title
    end

    if params[:landmark][:name] != nil
      puts 'New landmark entered'
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
    end

    redirect to "figures/#{@figure.id}"

  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])

    if ((@figure.name != params[:figure][:name]) && (params[:figure][:name] != nil))
      @figure.name = params[:figure][:name]
    end

    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]

    if params[:title][:name] != nil
      @title = Title.new(params[:title])
      @figure.titles << @title
    end

    if params[:landmark][:name] != nil
      @landmark = Landmark.new(params[:landmark])
      @figure.landmarks << @landmark
    end

    @figure.save

    redirect to "figures/#{@figure.id}"

  end

end
