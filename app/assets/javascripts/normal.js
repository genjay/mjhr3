function emp_get_name(e){
  if(e.length > 0){
    $.ajax({
      type: "GET",
      url: '/get_empid/?uid=' + e,
      dataType: "html",
      success: function(data) {
       if(data.length >0){
            var emp = data.split(",")
           $("#name").text(emp[0]);
           $("#doc_forget_employee_id").val(emp[1]);
       }else{
           $("#name").text("無此工號");
           $("#doc_forget_employee_id").val("");
       }
      }
    });
  }
}