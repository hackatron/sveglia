window.Timers = Backbone.Collection.extend({
  model: Timer,
  url: "/timers"
});