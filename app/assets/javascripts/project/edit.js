$(document).ready(function (){
  $("#pif").hide();
});

// function cellTypeHandle(obj){
//   if(obj.value === "None"){
//     $("li[data-name='None'] a").click();
//   }else if(obj.value === "SlideShow"){
//     $("li[data-name='Slideshow'] a").click();
//   }
// }

function toggleFullScreen() {
  $("#pif").addClass("full-screen");
}


function removeHeader(obj){
  _a = $("#pif").contents().find("#kernel_indicator")
  $("#pif").contents().find("#maintoolbar-container").append(_a)
  $("#pif").contents().find("#header-container").hide();
  $("#pif").contents().find("#menubar").hide();
  // $("#pif").contents().find()\
  $("#pif").contents().find("#maintoolbar-container").append(
    `
      <select id="show_type" class="form-control select-xs" onchange='$("li[data-name="+this.value+"] a").click()'>
        <option value="None">None</option>
        <option value="Slideshow">Slide Show</option>
      </select>
    `
  );

  $("#pif").contents().find("#maintoolbar-container").append(
    `
      <div class="btn-group">
        <button class="btn btn-default" id="full_screen_btn">
          <i class="fa-expand fa"></i>
        </button>
      </div>
    `
  );
  // $("#pif").contents().find("#header").hide();
  // $("#pif").contents().find("select#show_type").change(function (){
  //   if(this.value === "None"){
  //     // console.log("what the fuck None");
  //     $("li[data-name='None'] a").click();
  //   }else if(this.value === "SlideShow"){
  //     // console.log("what the fuck Show");
  //     $("li[data-name='Slideshow'] a").click();
  //     // alert("clicked");
  //   }
  // })
  $("#pif").show();
  $("#full_screen_btn").click(function (){
    $("#pif").addClass("full-screen");
  })
  obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}

