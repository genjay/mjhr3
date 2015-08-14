function emp_get_name(val){
  if(val.length > 0){
    $.ajax({
      type: "GET",
      url: '/get_empid/?uid=' + val,
      dataType: "html",
      success: function(data) {
       if(data.length >0){
            var emp = data.split(",")
           $("#name").text(emp[0]);
           $("#employee_id").val(emp[1]);
       }else{
           $("#name").text("無此工號");
           $("#employee_id").val("");
       }
      }
    });
  }
}