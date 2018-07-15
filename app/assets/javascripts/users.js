// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function showNameField() {
  var form = new FormData();
  form.append("name", $("#form_name").val());
  form.append("user_id", $("#form_id").val());
  console.log(form);
  $.ajax({
    url: "/projects",
    method: "post",
    data: {
      project: {
        name: $("#form_name").val(),
        user_id: $("#form_id").val()
      }
    },
    success: function(data) {
      console.log(data)
    }
  });
}