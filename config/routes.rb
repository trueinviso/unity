Unity::Engine.routes.draw do
  resource :subscription,
    except: [:delete]
  # link_to not working for destroy path
  get "/subscription/delete", to: "subscriptions#destroy"
end
