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
           $("#doc_overwork_overtype_id").val(emp[2])
       }else{
           $("#name").text("無此工號");
           $("#employee_id").val("");
       }
      }
    });
  }
}

function emp_get_ViewSchEmp(){
  var empid = $("#employee_id").val();
  var dutydate = $("#duty_date").val();
  if(empid == "" || dutydate == ""){
    alert("請輸入工號和出勤日期");
  }else{
    var empuid = $("#employee_uid").val();
    $.ajax({
      type: "GET",
      url: '/doc_forgets/get_ViewSchEmp/?empid=' + empuid + '&dutydate=' + dutydate,
      dataType: "html",
      success: function(data) {
        if(data.length >0){
            var duty = data.split(",")
           $("#begin_date").val(duty[0]);
           $("#begin_time").val(duty[1]);
           $("#end_date").val(duty[2]);
           $("#end_time").val(duty[3]);
       }else{
           $("#begin_date").val();
           $("#begin_time").val();
           $("#end_date").val();
           $("#end_time").val();
       }
      }
    });
  }
}