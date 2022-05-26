<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ToDo-List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
</head>
<body>
<br>
<div class="container">
<div class="row justify-content-center">
<div class="col-5">
	<form id="form1" action="todo" method="post" style="height:60px;" class="needs-validation" novalidate>
		<h1>待辦事項</h1>
		<em style="color:red;">*</em><em>項目</em><br>
		<div class="row">
			<div class="col">
				<input type="hidden" name="status" value="待完成">
				<input type="text" class="form-control" id="task" name="task" required>
				<div class="invalid-feedback">不得為空值</div>
			</div>
			<div class="col">
				<button id="send1" class="btn btn-primary btn-sm">送出</button>
			</div>
		</div>
	</form>
</div>
<div class="row gy-5 justify-content-center">
<div class="col-5">
	<ul class="nav nav-tabs">
  		<li class="nav-item">
    		<a class="nav-link active" data-bs-toggle="tab" href="#home">待完成</a>
  		</li>
  		<li class="nav-item">
    		<a class="nav-link" data-bs-toggle="tab" href="#menu1">已完成</a>
  		</li>
  	</ul>
  	<div class="tab-content">
  	<div class="tab-pane container active" id="home">
	<table id="table1" class="table table-hover">
	<tbody>
		<c:forEach var="t1" items="${todolist}">
			<c:if test="${t1.status=='待完成'}">
				<tr>
					<td style="display: none;">${t1.id}</td>
					<td>${t1.task}</td>
					<td><button class="btn btn-danger btn-sm del">移除</button> <button class="btn btn-success btn-sm com">完成</button></td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
	</table>
	</div>
	<div class="tab-pane container fade" id="menu1">
	<table id="table2" class="table table-hover">
	<tbody>
		<c:forEach var="t2" items="${todolist}">
			<c:if test="${t2.status=='已完成'}">
				<tr>
					<td>${t2.task}</td>
					<td style="display:none;">${t2.updatetime}</td>
					<td class="timeformat">${t2.updatetime}</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
	</table>
	</div>
	</div>
</div>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

<script>
(function () {
	  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  var forms = document.querySelectorAll('.needs-validation')

	  // Loop over them and prevent submission
	  Array.prototype.slice.call(forms)
	    .forEach(function (form) {
	      form.addEventListener('submit', function (event) {
	        if (!form.checkValidity()) {
	          event.preventDefault()
	          event.stopPropagation()
	        }

	        form.classList.add('was-validated')
	      }, false)
	    })
	})()
</script>
<script>
function getDateTimeStamp (dateStr) {
	return Date.parse(dateStr.replace(/-/gi,"/"));
}
function getDateDiff (dateStr) {
	var publishTime = getDateTimeStamp(dateStr)/1000,
	d_seconds,
	d_minutes,
	d_hours,
	d_days,
	timeNow = parseInt(new Date().getTime()/1000),
	d,
	date = new Date(publishTime*1000),
	Y = date.getFullYear(),
	M = date.getMonth() + 1,
	D = date.getDate(),
	H = date.getHours(),
	m = date.getMinutes(),
	s = date.getSeconds();

	if (M < 10) {
		M = '0' + M;
	}
	if (D < 10) {
		D = '0' + D;
	}
	if (H < 10) {
		H = '0' + H;
	}
	if (m < 10) {
		m = '0' + m;
	}
	if (s < 10) {
		s = '0' + s;
	}
	d = timeNow - publishTime;
	d_days = parseInt(d/86400);
	d_hours = parseInt(d/3600);
	d_minutes = parseInt(d/60);
	d_seconds = parseInt(d);
	if(d_days > 0 && d_days < 3){
		return Y+'-'+M+'-'+D;
	}else if(d_days <= 0 && d_hours > 0){
	    return d_hours + '小時前';
	}else if(d_hours <= 0 && d_minutes > 0){
	    return d_minutes + '分鐘前';
	}else if (d_seconds < 60) {
		if (d_seconds <= 0) {
			return '0秒前';
		}else {
			return d_seconds + '秒前';
		}
	}else if (d_days >= 3 && d_days < 30){
		return M + '-' + D + ' ' + H + ':' + m;
	}else if (d_days >= 30) {
		return Y + '-' + M + '-' + D + ' ' + H + ':' + m;
	}
}
$(".timeformat").each(function(i,val){
	$(this).text(getDateDiff($(val).text()));
})
setInterval(()=>{
	$(".timeformat").each(function(i,val){
	$(this).text(getDateDiff($(val).prev().text()));})},1000);
</script>
<script>
$("#form1").submit(function(e){
	e.preventDefault();
	if($("#task").val()){
		$("#task").attr("readonly","true");
		$("#send1").attr("disabled","true");
		let formData = new FormData($("#form1")[0]);
		$.ajax({
			type: "post",
			url: "todo",
			contentType: false,
			processData: false,
			data: formData,
			success: function(data) {
				Swal.fire({
					  position: 'center',
					  icon: 'success',
					  title: '新增成功',
					  showConfirmButton: false,
					  timer: 1500
					})
				setTimeout(function(){
					let tr1=$("<tr>");
					let td1=$("<td>").text(data['id']).hide();
					let td2=$("<td>").text(data['task']);
					let td3=$("<td>");
					let button1=$("<button>").text("移除").addClass("btn btn-danger btn-sm del").click(del);
					let button2=$("<button>").text("完成").addClass("btn btn-success btn-sm com").click(com);
					td3.append(button1).append(" ").append(button2);
					tr1.append(td1).append(td2).append(td3);
					$("#table1").append(tr1);
				},1500);
			},
			error: function(data) {
				Swal.fire({
					  position: 'center',
					  icon: 'error',
					  title: '新增失敗',
					  showConfirmButton: false,
					  timer: 1500
					})
			},
			complete: function(data) {
				setTimeout(function(){
					$("#form1").removeClass("was-validated");
					$("#task").removeAttr("readonly","true").val("");
					$("#send1").removeAttr("disabled","true");
				},1500);
			}
		})
	}
})
function del(){
	let thisTr=$(this).parent().parent()
	let id=thisTr.children().eq(0).text();
	let task=thisTr.children().eq(1).text();
	Swal.fire({
		  title: '提示',
		  text: "是否移除'"+task+"'？",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '確認',
		  cancelButtonText: '取消',
		}).then((result) => {
		  if (result.isConfirmed) {
		    $.ajax({
				type: "delete",
				url: "todo/"+id,
				success: function(data){
					thisTr.remove();
				}
			})
		  }
		})
}
$(".del").click(del);

function com(){
	let thisTr=$(this).parent().parent()
	let id=thisTr.children().eq(0).text();
	let task=thisTr.children().eq(1).text();
	Swal.fire({
		  title: '提示',
		  text: "是否完成'"+task+"'？",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '確認',
		  cancelButtonText: '取消',
		}).then((result) => {
		  if (result.isConfirmed) {
		    $.ajax({
				type: "put",
				url: "todo/"+id,
				success: function(data){
					window.location.reload();
				}
			})
		  }
		})
}
$(".com").click(com);
</script>


</body>
</html>