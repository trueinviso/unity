Unity::Engine.routes.draw do
  resource :subscription,
    only: [:new, :create]
end
