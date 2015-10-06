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
  var emp = document.getElementsByName("employee[]");
  var emp_id = document.getElementsByName("employee_id[]");
  var emp_name = $("#display label");
  for(var i=0; i<emp.length; i++){
    if(e == emp[i]){
      emp_id[i].value = id;
      emp_name[i].innerHTML = name;
      break;
    }
  }
}

function get_amt_index(e){
  var element = document.getElementsByName("amt[]");
  for(var i=0; i<element.length; i++){
    if(e == element[i]){
      return [element, i];
    }
  }
}

function get_next_line(e){
  var obj = get_amt_index(e);
  if(obj[1]+1 == obj[0].length){
    add_tab();
  }
}

function add_tab(){
  var tbody = $("#display > tbody:last");
  tbody.append("<tr><td><input type=\"text\" name=\"employee[]\" onChange=\"emp_get_name_multi(this)\"/><input type=\"hidden\" name=\"employee_id[]\"/><label></label></td><td><input type=\"text\" name=\"amt[]\" onfocus=\"get_next_line(this)\"/></td></tr>");
}