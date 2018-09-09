function autoResize(obj){
  var height = obj.contentWindow.document.body.scrollHeight;
  obj.style.height = (height > 768)? height+'px':'768px'
}
