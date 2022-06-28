<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style type="text/css">
 .error {
      color: red;
      background-color: #acf;
   }
.card {
box-shadow: rgba(0, 0, 0, 0.15) 0px 5px 15px 0px;
}
</style>
</head>
<jsp:include page="Navbar.jsp" />
</head>
<body>
	<div class="container pt-5">
		<div class="row justify-content-center">
			<div class="col-lg-10 col-12 m-2 p-2">
				<form method="post"  id="form">
				   <div class="mb-3">
				    <label for="nom" class="form-label">Nom</label>
				    <input type="text" class="form-control" id="nom" aria-describedby="emailHelp" name="nom" required>
				  </div>
				  <div class="mb-3">
				    <label for="prenom" class="form-label">Prenom</label>
				    <input type="text" class="form-control" id="prenom" aria-describedby="emailHelp" name="prenom" required>
				  </div>
				  <div class="mb-3">
				    <label for="telephone" class="form-label">Telephone</label>
				    <input type="tel" class="form-control" id="telephone" aria-describedby="emailHelp" maxlength="10" name="telephone" required>
				  </div>
				  <div class="mb-3">
				    <label for="cin" class="form-label">Cin</label>
				    <input type="text" class="form-control" id="cin" aria-describedby="emailHelp" name="cin" required>
				  </div>
				    <input type="hidden" class="form-control" id="numero" aria-describedby="emailHelp" readonly name="numero" value="<%= request.getParameter("numero")%>" >
				   <div class="mb-3">
				    <label for="dated" class="form-label">Date Start</label>
				    <input type="date" class="form-control" id="dated" aria-describedby="emailHelp" name="dated" required>
				  </div>
				   <div class="mb-3">
				    <label for="datef" class="form-label">Date End</label>
				    <input type="date" class="form-control" id="datef" aria-describedby="emailHelp" name="datef" required>
				  </div>
				    <input type="hidden" class="form-control"  aria-describedby="emailHelp" name="prixtotal" id="prixtotal" readonly value="<%= request.getParameter("prix") %>">
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script><script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

var dated;
var datef;
$("#dated").change(function(){
	dated = this.value;
});	

$("#datef").change(function(){
	datef = this.value;
});	

$("#form").submit(function(event){
	event.preventDefault();
	var start_date = new Date(dated); 
	var end_date = new Date(datef); 
	var diff_ms = end_date.getTime() - start_date.getTime();
	var diff = diff_ms/(60*60*24*1000);
	if(diff_ms > 0){
		$.ajax({
            type : 'POST',
            data : {
                nom : $('#nom').val(),
                prenom : $('#prenom').val(),
                cin : $('#cin').val(),
                telephone :$('#telephone').val(),
                prixtotal :$('#prixtotal').val(),
                numero : $('#numero').val(),
                dated :$('#dated').val(),
               	datef :$('#datef').val()
            },
            url : '/HotelWeb/Home',
            success : function(result) {
            	navigator.clipboard.writeText(result);
              	//console.log(result);
            	//console.log("hhbh  ddoonne");
            	  swal({
            		  title: "Good job!",
            		  text: "Ton jeton est "+result+", il est copié vers votre presse-papier, garde le !",
            		  icon: "success",
            		  button: "D'accord",
            		}).then(() => {
                 	 window.location.replace("http://localhost:8081/HotelWeb/Home");
            	  });    
            	}
        });
	}else {
		$("#datef").val(null);
		$("#datef").focus();
		//alert("La date de fin doit être postérieure à la date de début");	
	}

})

</script>
</body>
</html>