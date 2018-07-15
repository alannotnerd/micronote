$(document).ready(function (){
  $("#pif").hide();
  console.log($("#pif").is(":hidden"));
  console.log("onload");
});


function removeHeader(obj){
  $("#pif").contents().find("#header-container").hide();
  $("#pif").contents().find("#menubar").hide();
  // $("#pif").contents().find("#header").hide();
  $("#pif").show();
  obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
  // $(($("#pif").contents()[0])).ready(function(){
  //   setTimeout($("#pif").contents().find("#header").hide(),500);
  // })
}

