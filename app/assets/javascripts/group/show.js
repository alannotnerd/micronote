function load_token(e){
  console.log("load data");
  $.get(document.location + "/invitation").done(function(data){
    // JSON.parse(data);
    console.log(document.location);
    // console.log(data.token);
    $("#token").val(data.token);
  })  
}
