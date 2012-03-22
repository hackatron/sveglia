function PusherNotifier(channel, events) {
  for(var i = 0; i < events.length; i++) {
    channel.bind(events[i], this._handleNotification);
  }
};

PusherNotifier.prototype._handleNotification = function(data) {
  $.gritter.add({
    title: 'New notification',
    text: data.message.replace(/\\/g, '')
  });
};