//
// Models
//

window.Timer = Backbone.Model.extend();

window.TimerCollection = Backbone.Collection.extend({
  model: Timer,
  url: "/timers"
});


//
// Views
//

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

window.TimerListItemView = Backbone.View.extend({

  tagName: "li",

  template: _.template($('#tpl-timer-list-item').html()),

  render: function (eventName) {
    $(this.el).html(this.template(this.model.toJSON()));
    return this;
  }

});

window.TimerView = Backbone.View.extend({

  template: _.template($('#tpl-timer-details').html()),

  render: function (eventName) {
    $(this.el).html(this.template(this.model.toJSON()));
    return this;
  }

});


//
// Router
//

var AppRouter = Backbone.Router.extend({

  routes: {
    "": "list",
    "timer/:id": "timerDetails"
  },

  list: function () {
    this.timerList = new TimerCollection();
    this.timerListView = new TimerListView({model:this.timerList});
    this.timerList.fetch();
    $('#timers').html(this.timerListView.render().el);
  },

  timerDetails: function (id) {
    this.timer = this.timerList.get(id);
    this.timerView = new TimerView({model:this.timer});
    $('#content').html(this.timerView.render().el);
  }
});

var app = new AppRouter();
Backbone.history.start();