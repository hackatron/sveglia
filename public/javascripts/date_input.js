(function () {
  $(document).ready(function () {
    var messages = ["#500", "#vainleto", "#freelancelife"];
    var input = $("#date_input"), date_string = $("#your_date"), date = null;
    var input_empty = "*Enter a date (or time) here", empty_string = "Type a date above";

    input.val(input_empty);
    date_string.text(empty_string);

    input.keyup(function (e) {
      date_string.removeClass();
      if (input.val().length > 0) {
        date = Date.parse(input.val());
        if (date !== null) {
          input.removeClass();
          date_string.addClass("accept").text(date.toString("dddd, MMMM dd, yyyy h:mm:ss tt"));
        } else {
          input.addClass("validate_error");
          date_string.addClass("error").text(messages[Math.round(messages.length * Math.random())]);
        }
      } else {
        date_string.text(empty_string).addClass("empty");
      }
    });

    input.focus(function (e) {
      if (input.val() === input_empty) {
        input.val("");
      }
    });
    
    input.blur( function (e) {
      if (input.val() === "") {
        input.val(input_empty).removeClass();
      }
    });
  });
}());