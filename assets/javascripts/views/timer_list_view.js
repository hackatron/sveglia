window.TimerListView = Backbone.View.extend({

  tagName: "ul",

  initialize: function () {
    this.model.bind("reset", this.render, this);
  },

  render: function (eventName) {
    _.each(this.model.models, function (timer) {
      $(this.el).append(new TimerListItemView({model:timer}).render().el);
    }, this);
    return this;
  }

});