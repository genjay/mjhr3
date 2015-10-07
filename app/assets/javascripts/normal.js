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

function emp_get_name_multi(e){
  var val = e.value;
  if(val.length > 0){
    $.ajax({
      type: "GET",
      url: '/get_empid/?uid=' + val,
      dataType: "html",
      success: function(data) {
        if(data.length >0){
           var emp = data.split(",")
           set_employee_name(e, emp[0], emp[1]);
        }else{
           set_employee_name(e, "無此工號", "");
        }
      }
    });
  }
}

function set_employee_name(e, name, id){
  var emp_uid = document.getElementsByName("employee_uid");
  var emp_id = document.getElementsByName("employee_id");
  var emp_name = $("#display label");
  for(var i=0; i<emp_uid.length; i++){
    if(e == emp_uid[i]){
      emp_id[i].value = id;
      emp_name[i].innerHTML = name;
      break;
    }
  }
}

function get_amt_index(e){
  var element = document.getElementsByName("amt");
  for(var i=0; i<element.length; i++){
    if(e == element[i]){
      return [element, i];
    }
  }
}

function get_next_line(e){
  var obj = get_amt_index(e);
  if(obj[1]+1 == obj[0].length){
    document.getElementById("add").click();
  }
}