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
           set_employee_name(e, data);
        }else{
           set_employee_name(e, "");
        }
      }
    });
  }else{
    set_employee_name(e, "");
  }
}

function set_employee_name(e, data){
  var id, name, dep, emp_data;
  if(data.indexOf(",") == -1){
      id = "";
      name = "無此工號";
      dep = "";
  }else{
    emp_data = data.split(",");
    name = emp_data[0];
    id = emp_data[1];
    dep = emp_data[3];
  }

  var emp_uid = document.getElementsByName("employee_uid");
  var emp_id = document.getElementsByClassName("employee_id");
  var emp_name =  document.getElementsByName("employee_name");
  var emp_dep =  document.getElementsByName("employee_dep");
  
  for(var i=0; i<emp_uid.length; i++){
    if(e == emp_uid[i]){
      emp_id[i].value = id;
      emp_name[i].value = name;
      emp_dep[i].value = dep;
      break;
    }
  }
}

function get_amt_index(e){
  var element = document.getElementsByClassName("amt");
  for(var i=0; i<element.length; i++){
    if(e == element[i]){
      return [element.length, i];
    }
  }
}

function get_next_line(e){
  var obj = get_amt_index(e);
  if(obj[1]+1 == obj[0]){
    add_amt_row();
  }
}

function add_amt_row(){
  var name = new Date().getTime();
  $("#details_table > tbody").append("<tr><td><span class=\"del_span\" /></td><td><label></label> <input type=\"checkbox\" name=\"delete\" /></td><td><input type=\"text\" class=\"employee_uid\" name=\"employee_uid\" onchange=\"emp_get_name_multi(this)\" /><input type=\"hidden\" class=\"employee_id\" name=\"month_other[month_other_details_attributes][" + name + "][employee_id]\" /></td><td><input type=\"text\" class=\"employee_name\" name=\"employee_name\" disabled=\"true\" /></td><td><input type=\"text\" name=\"employee_dep\" class=\"employee_dep\" disabled=\"true\" /></td><td><input type=\"text\" class=\"amt\" name=\"month_other[month_other_details_attributes][" + name + "][amt]\" onfocus=\"get_next_line(this)\" /><input type=\"hidden\" name=\"month_other[month_other_details_attributes][" + name + "][_destroy]\" class=\"destroy\" value=\"false\" /></td></tr>");
  reset_num();
}

function add_first_row(){
  var data = document.getElementsByClassName("employee_id");
  if(data.length <= 0){
    $("#details_table > tbody").append("<tr><td><span class=\"del_span\" /></td><td><label>1</label> <input type=\"checkbox\" name=\"delete\" /></td><td><input type=\"text\" class=\"employee_uid\" name=\"employee_uid\" onchange=\"emp_get_name_multi(this)\" /><input type=\"hidden\" class=\"employee_id\" name=\"month_other[month_other_details_attributes][0][employee_id]\" /></td><td><input type=\"text\" class=\"employee_name\" name=\"employee_name\" disabled=\"true\" /></td><td><input type=\"text\" name=\"employee_dep\" class=\"employee_dep\" disabled=\"true\" /></td><td><input type=\"text\" class=\"amt\" name=\"month_other[month_other_details_attributes][0][amt]\" onfocus=\"get_next_line(this)\" /><input type=\"hidden\" name=\"month_other[month_other_details_attributes][0][_destroy]\" class=\"destroy\" value=\"false\" /></td></tr>");
  }else{
    add_amt_row();
  }
}

function reset_num(){
  $("#details_table label").each(function(index){
    $(this).text(index + 1);
  });
}

function checkform(){
  var emp_uid = document.getElementsByName("employee_uid");
  var emp_id = document.getElementsByClassName("employee_id");
  var emp_amt = document.getElementsByClassName("amt");
  var status = true;
  var line = 0;

  for(var i=0; i<emp_id.length; i++){
    var uid = emp_uid[i].value;
    var id = emp_id[i].value;
    var amt = emp_amt[i].value;

    if(id == "" && amt.length == 0 && uid.length ==0){
      continue;
    }else{
      if(id != "" && isNumber(amt)){

      }else{
        line = i + 1;
        status = false;
        break;
      }
    }
  }

  if(status){
      return true;
    }else{
      alert("明細第" + line + "行資料有誤");
      return false;
    }  
}

function isNumber(str){
  var pattern = /^\d+$/;
  if(str == "" || str.length == 0){
    return false
  }else{
    return pattern.test(str);
  }
}

function del_details(){
  var destroy = document.getElementsByClassName("destroy");
  var span = document.getElementsByClassName("del_span");
  var details = document.getElementsByName("delete");
  var len = details.length;
  for(var i=0; i<=len; i++){
    if(details[i].checked == true){
       destroy[i].value = "true";
       span[i].innerHTML = "X";
    }else{
       destroy[i].value = "false";
       span[i].innerHTML = "";
    }
  }
}