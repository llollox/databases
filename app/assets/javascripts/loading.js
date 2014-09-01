$(document).ready(function(){
  $("form").submit(function(){
      $("#loadingModal").modal("show");
  });
  $(".show-loading").on('click', function(){
      $("#loadingModal").modal("show"); 
  });
  
  $(document).bind("page:change",function(){
    $("#loadingModal").modal("hide");
  });
});