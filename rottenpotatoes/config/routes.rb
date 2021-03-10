Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  match '/similar_movies/:id', to:"movies#find_similar", as: :similar_movies, via: [:get]
end
