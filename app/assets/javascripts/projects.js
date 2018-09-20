const autoResize = function (obj) {
  var height = obj.contentWindow.document.body.scrollHeight;
  console.log("inner height: " + height);
  $(obj).css("height", height + 100 + "px");
};

const getData = function() {
  var tree_data = [
    {
      text: "Parent 1",
      nodes: [
        {
          text: "Child 1",
          nodes: [
            {
              text: "Grandchild 1"
            },
            {
              text: "Grandchild 2"
            }
          ]
        },
        {
          text: "Child 2"
        }
      ]
    },
    {
      text: "Parent 2"
    },
    {
      text: "Parent 3"
    },
    {
      text: "Parent 4"
    },
    {
      text: "Parent 5"
    }
  ];
  console.log("what the fuck");
  return tree_data;
}

const removeHeader = function(obj){
  var frame = $("#pif");
  _a = frame.contents().find("#kernel_indicator");
  frame.contents().find("#maintoolbar-container").append(_a);
  frame.contents().find("#header-container").hide();
  frame.contents().find("#menubar").hide();
  frame.contents().find("#cell_type").after(`
      <select id="show_type" class="form-control select-xs" onchange='$("li[data-name="+this.value+"] a").click()'>
        <option value="None">None</option>
        <option value="Slideshow">Slide Show</option>
      </select>
    `
  );

  frame.contents().find("#show_type").after(`
      <div class="btn-group">
        <button class="btn btn-default" id="full_screen_btn">
          <i class="fa-expand fa"></i>
        </button>
      </div>
    `
  );

  var b = function (){
    var container = $("#root");
    if (container.hasClass("full-screen")){
      $("header").show();
      $("footer").show();
      $("body").removeClass("full-screen");
      container.removeClass("full-screen");
      frame.removeClass("full-screen");
      // var height = $(obj.contentWindow.document).find("#notebook").css("height")
      frame.css("height", "768px");

    }else{
      $("header").hide();
      $("footer").hide();
      frame.css("height", "100%");
      frame.addClass("full-screen");
      container.addClass("full-screen");
      $("body").addClass("full-screen");
    }

  }
  frame.show();
  frame.contents().find("#full_screen_btn").click(b);

  $(obj).css("height", "768px");
}


