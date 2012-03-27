//= require_self

var AppRouter = Backbone.Router.extend({

  routes: {
    "": "list",
    "timers/:id": "timerDetails"
  },

  list: function () {
    this.timerList = new Timers();
    this.timerListView = new TimerListView({model:this.timerList});
    this.timerList.fetch();
    $('#timers').html(this.timerListView.render().el);
  },

  timerDetails: function (id) {
    this.timer = this.timerList.get(id);
    this.timerView = new TimerView({model:this.timer});
    $('#timer_details').html(this.timerView.render().el);
  }
});

var app = new AppRouter();
Backbone.history.start();