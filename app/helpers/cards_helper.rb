module CardsHelper
  def status_color(status)
    colors = { active: 'blue', completed: 'green', cancelled: 'red', expired: 'yellow'}
    colors[status.to_sym]
  end
end
