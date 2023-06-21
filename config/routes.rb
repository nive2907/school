Rails.application.routes.draw do
  post '/enrollments', to: 'enrollments#create'
  put '/enrollments/:id/approve', to: 'enrollments#approve'
  post '/courses', to: 'courses#create'
  post '/schools', to: 'schools#create'
  put '/schools/:id', to: 'schools#update'
  get '/students', to: 'students#index'
  get '/students/:id', to: 'students#show'
  put '/students/:id/add_to_batch', to: 'students#add_to_batch'
  post '/school_admin', to: 'school_admin#create'
end
