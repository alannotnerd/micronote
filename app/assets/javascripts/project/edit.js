$(document).ready(function (){
  $("#pif").hide();
});

function removeHeader(obj){
  _a = $("#pif").contents().find("#kernel_indicator")
  $("#pif").contents().find("#maintoolbar-container").append(_a)
  $("#pif").contents().find("#header-container").hide();
  $("#pif").contents().find("#menubar").hide();
  $("#pif").contents().find("#maintoolbar-container").append(`
      <select id="show_type" class="form-control select-xs" onchange='$("li[data-name="+this.value+"] a").click()'>
        <option value="None">None</option>
        <option value="Slideshow">Slide Show</option>
      </select>
    `
  );

  $("#pif").contents().find("#maintoolbar-container").append(`
      <div class="btn-group">
        <button class="btn btn-default" id="full_screen_btn">
          <i class="fa-expand fa"></i>
        </button>
      </div>
    `
  );

  var b = function (){
    var container = $("#pif").parent();
    if (container.hasClass("full-screen")){
      $("header").show();
      $("footer").show();
      $("body").removeClass("full-screen");
      container.removeClass("full-screen");
      $("#pif").removeClass("full-screen");
      $("#pif").css("height", "768px");

    }else{
      $("header").hide();
      $("footer").hide();
      $("#pif").css("height", "100%");
      $("#pif").addClass("full-screen");
      container.addClass("full-screen");
      $("body").addClass("full-screen");
    }

  }
  $("#pif").show();
  $("#pif").contents().find("#full_screen_btn").click(b);
  obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}

