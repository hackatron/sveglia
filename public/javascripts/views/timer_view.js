window.TimerView = Backbone.View.extend({

  template: _.template($('#tpl-timer-details').html()),

  render: function (eventName) {
    $(this.el).html(this.template(this.model.toJSON()));
    return this;
  }

});