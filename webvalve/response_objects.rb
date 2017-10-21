module ResponseObjects
  def customer(params)
    {
      customer: {
        id: params[:id]
      }
    }
  end
end
