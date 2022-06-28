<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style type="text/css">
.card {
box-shadow: rgba(0, 0, 0, 0.15) 0px 5px 15px 0px;
}
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
}
</style>
</head>
<jsp:include page="Navbar.jsp" />
<body>
<div class="container pt-5">
		<div class="row">
			<c:forEach items="${AllReservations}" var="reservation">	
				<div class="card col-lg-3 col-md-4 col-sm-6 col-12 m-3 p-2" >
				<div class="card-header">
					<p class="card-title">Client : ${reservation.getCin_client()}</p>
				</div>
				<div class="card-body">
					<p class="card-title"> La chambre : ${reservation.getNumero_chambre()}</p>
					<p class="card-title">à partir de ${reservation.getDate_debut()} </p>
					<p class="card-title">jusqu'à ${reservation.getDate_fin()}</p>
					<p class="card-title">Prix total:  ${reservation.getPrix_total()}</p>
				</div>
				<div class="card-footer">
					<button class="btn btn-primary" onclick="showmodal('${reservation.getDate_debut()}','${reservation.getDate_fin()}','${reservation.getId()}')" >Retarder</button>
					<button class="btn btn-primary" onclick="deleteReservation('${reservation.getId()}')" >Annuler</button>
				</div>
				</div>
			</c:forEach>
		</div>
</div>

<!-- The Modal -->
<div id="myModal" class="modal">
	  <!-- Modal content -->
	  <div class="modal-content">
	    <span id="close">&times;</span>
		<div class="row justify-content-center">
				<div class="col-lg-10 col-12 m-2 p-2">
					<form method="post"  id="form">
					   <input type="hidden" id="id" name="id" >
					   <div class="mb-3">
						    <label for="dated" class="form-label">Date Start</label>
						    <input type="date" class="form-control" id="dated" aria-describedby="emailHelp" name="dated" required>
					    </div>
					   <div class="mb-3">
						    <label for="datef" class="form-label">Date End</label>
						    <input type="date" class="form-control" id="datef" aria-describedby="emailHelp" name="datef" required>
					   </div>
					  <button type="submit" class="btn btn-primary">Submit</button>
					  
					</form>
				</div>
		</div>  
	</div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script><script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">



function deleteReservation(ID){
	
	swal({
		  title: "Êtes-vous sûr?",
		  text: "Vous ne pourrez pas revenir en arrière!",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
	  .then((result) => {
		  if (result) {
			  $.ajax({
			        type : 'POST',
			        data : {
			            id : ID,
			           	method :"delete"
			        },
			        url : '/HotelWeb/Auth',
			        success : function(result) {
			        	console.log(result);
			           	if(result == "no") {
			        		 swal({
			           		  title: "Oups !",
			           		  text: "Une erreur s'est produite, essayez plus tard ",
			           		  icon: "warrning",
			           		  button: "D'accord",
			           		});
			        	}else {
			        		 swal({
			              		  title: "Passer avec succès !",
			              		  text: "Votre reservation a été bien supprimé ",
			              		  icon: "success",
			              		  button: "D'accord",
			              		}).then(()=> {
			                   	 window.location.reload(true);

			              		});
			        		 
			        		}
			        	}
			        	
			    })
		  }
		})
	
	
	
    
    
    
}


function showmodal(DateDebut , DateFin , Id){	
	var modal = $("#myModal");
	var span = $("#close");
			$("#id").val(Id);
			
			$("#dated").val(DateDebut);
			$("#datef").val(DateFin);	
			console.log($("#id").val());
			console.log($("#datef").val());
			console.log($("#dated").val());
			
			modal.css("display" , "block");	
			$('#close').css('cursor', 'pointer');
		span.click(function(event) {
			modal.css("display" , "none");
		})		
}
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
                id : $('#id').val(),
                dated :$('#dated').val(),
               	datef :$('#datef').val(),
               	method :"update"
            },
            url : '/HotelWeb/Auth',
            success : function(result) {
            	console.log(result);
         	
               	if(result == "no") {
            		 swal({
               		  title: "Oups !",
               		  text: "Cette chambre peut n'étre pas disponible pour la date demandée ",
               		  icon: "error",
               		  button: "D'accord",
               		});
            	}else {
	            	  swal({
	            		  title: "Good job!",
	            		  text: "Votre breservation bien été modifiée !",
	            		  icon: "success",
	            		  button: "D'accord",
	            		}).then(() => {
	                 	 window.location.reload(true);
	            	  }); 
            		}
            	}
            	
        })
	
	}else {
		$("#datef").val(null);
		$("#datef").focus();
		//alert("La date de fin doit être postérieure à la date de début");	
	}

})
</script>
</body>
</html>