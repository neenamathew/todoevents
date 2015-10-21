 $(document).ready(function() {

 	var el = document.getElementById("count_id");
    var count = parseInt( $(el).attr("value"));

 //new todo
   $('.todoevents_new').change(function(){
      var new_todo = $(this).val();
      $.ajax({
        method: 'POST',
        url:'/todoevents',
        cache: false,
        data: {name: new_todo},
        success: function(html){
         }
      });
      $(".todoevents_new").val('');
	   count += 1;
     $('#count_id').text(count+" items left");
    });

 //destroy todo
  $('body').on('click', 'a.delete', function() {
     var object_id = $(this).attr("value");
      count -= 1;
      $('#count_id').text(count+" items left");
      $.ajax({
      method: "DELETE",
      url: "/todoevents",
      format: 'js',
      cache: false,
      data: {id: object_id},
      success: function(html){
      }
    });
    $("#delete"+object_id).parent().remove();
  });

   //edit todo
   $('body').on('dblclick', 'div.todoevents_edit', function() {
     var object_id = $(this).attr("id");
     var currentEle = $(this);
     var elem = document.getElementById (object_id);
 	   var data = elem.innerHTML;
      if ($(data).html())
 	 	{
 	 		var d =  $(data).html(); 
 	 		var status = "completed";
 	 	}
 	 else
 	 	{ 
 	 		var d = elem.innerHTML;
 	 		var status = "active"; 
 	 	}
 	 $('#'+object_id).html("");
 	 $('#'+object_id).text(d); 
     var value = $(this).html();
     $(currentEle).replaceWith('<input class="thVal" type="text" value="' + value + '" />');
     $(".thVal").focus();
     $(".thVal").change(function (event) {
     var value_ = $(".thVal").val().trim();
      $(currentEle).replaceWith($(".thVal").val().trim());
  	 if (status == "completed")
  	 {
    	 $('#'+object_id).html("<strike> "+value_+"</strike>");
 	 }
     $.ajax({
      method: 'PATCH',
      url:'/todoevents/'+object_id,
      cache: false,
      data: {id: object_id, name: value_},
      success: function(html){
        }
      });
      $(document).click(function () {
        $(object_id).html($(".thVal").val().trim());
         var value_ = $(".thVal").val().trim();
    	 $(currentEle).replaceWith($(".thVal").val().trim());
        });
      });

    });

//complete todo
$('body').on('click', 'input.complete', function() {
    var object_id = $(this).attr("value");
      $.ajax({
      method: "POST",
      url: "/todoevents/complete",
      format: 'js',
      cache: false,
      data: {id: object_id},
      success: function(html){
      }
    });
	var elem = document.getElementById (object_id);
  	var content = elem.innerHTML;
	$('#'+object_id).html("<strike>"+ content +"</strike");
    count -= 1;
    $('#count_id').text(count+" items left");

  });

//complete all todos
$('body').on('click', 'input.select_all', function() {
	alert("enter");
      $.ajax({
      method: "POST",
      url: "/todoevents/complete_all",
      format: 'js',
      cache: false,
      success: function(html){
      	alert("success");
      }
    });
  });

//unmark todo
$('body').on('click', 'input.unmark', function() {
  var object_id = $(this).attr("value");
      var currentEle = $(this);
    $.ajax({
      method: "POST",
      url: "/todoevents/unmark",
      format: 'js',
      cache: false,
      data: {id: object_id},
      success: function(html){
      }
    });
   	var elem = document.getElementById (object_id);
 	var data = elem.innerHTML;
	$('#'+object_id).html("");
    $('#'+object_id).text($(data).html()); 
    count += 1;
    $('#count_id').text(count+" items left");

  });

//filter
$(".filter").click(function(){
	$(".filter").removeClass("clicked"); 
    $(this).addClass("clicked"); 
	var status_value = $(this).attr("value");
	$.ajax({
		method: "POST",
		url: "/todoevents/status_order",
		format: 'js',
		cache: false,
		data: {status: status_value},
		success: function(html){
		}
	});
});

});