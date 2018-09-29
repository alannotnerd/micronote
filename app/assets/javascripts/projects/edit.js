$(document).ready(function (){
  $("#pif").hide();
  // console.log("what the fuck main");
  // const tree = $("#tree").treeview({
  //   data: getData(),
  //   showBorder: false
  // });
  $(".file").on('change', function () {
    console.log("start uploading file");
    var file = this.files[0];
    if (file.size > 1024 * 1024) {
      alert('max upload size is 1M')
    }else{
      $.ajax({
        // Your server script to process the upload
        url: 'upload',
        type: 'POST',

        data: new FormData($('form')[0]),


        cache: false,
        contentType: false,
        processData: false,

        // Custom XMLHttpRequest
        xhr: function() {
          var myXhr = $.ajaxSettings.xhr();
          if (myXhr.upload) {
            // For handling the progress of the upload
            myXhr.upload.addEventListener('progress', function(e) {
              if (e.lengthComputable) {
                $('progress').attr({
                  value: e.loaded,
                  max: e.total,
                });
              }
            } , false);
          }
          return myXhr;
        }
      }).done(function (data) {
        console.log(data);
      });
    }
  });

  $('.upload-button').on('click', function() {
    $('.file').click();
  });
});

