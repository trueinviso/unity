Unity::Engine.routes.draw do
  resource :subscription,
    except: [:delete]
  resource :payment_method,
    only: [:edit, :update],
    controller: :payment_method,
    path: "payment-method"
  # link_to not working for destroy path
  get "/subscription/delete", to: "subscriptions#destroy"
end
