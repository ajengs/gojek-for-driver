App.orders = App.cable.subscriptions.create "OrdersChannel",
  collection: -> $("[data-channel='orders']")
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $(".orders #main").html(data.html)
    $("[data-channel='orders']").append(data.order)
