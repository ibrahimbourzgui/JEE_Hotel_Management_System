<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestion Hotel</title>
    <link rel="stylesheet" href="css/templatemo-style.css">                                   

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
<style><!-- HTML !-->
<button class="button-40" role="button">Button 40</button>

/* CSS */
.button-40 {
  background-color: #111827;
  border: 1px solid transparent;
  border-radius: .75rem;
  box-sizing: border-box;
  color: #FFFFFF;
  cursor: pointer;
  flex: 0 0 auto;
  font-family: "Inter var",ui-sans-serif,system-ui,-apple-system,system-ui,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
  font-size: 1.125rem;
  font-weight: 600;
  line-height: 1.5rem;
  padding: .75rem 1.2rem;
  text-align: center;
  text-decoration: none #6B7280 solid;
  text-decoration-thickness: auto;
  transition-duration: .2s;
  transition-property: background-color,border-color,color,fill,stroke;
  transition-timing-function: cubic-bezier(.4, 0, 0.2, 1);
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
}

.button-40:hover {
  background-color: #374151;
    color: white;
  
}

.button-40:focus {
  box-shadow: none;
  outline: 2px solid transparent;
  outline-offset: 2px;
     color: white;
  
}

@media (min-width: 768px) {
  .button-40 {
    padding: .75rem 1.5rem;
  }
}</style>

</head>
<jsp:include page="Navbar.jsp" />
<body>
		 <ul class="cd-hero-slider" >

                <!-- Page 1 Home -->
                <li class="selected" >
                    <div class="cd-full-width" >
                        <div class="container">
                            <div class="row">
	                                  <c:forEach items="${allchambres}" var="chambre">	
									 	<div class="col-xs-12 mr-5">
											<div class="text-xs-left tm-textbox tm-textbox-padding tm-bg-white-translucent tm-3-col-textbox-inner">	
												<h2 class="tm-text-title">Chambre N°: ${chambre.getNumero()}</h2>
												<h6 class="tm-text">A partir de ${chambre.getPrix()} MAD</h6>
												<p class="tm-text"> Détails  : ${chambre.getType()}</p>
												<hr>
												<button  class="btn btn-primary" onclick="showmodal(${chambre.getNumero()},${chambre.getPrix()})" >Reserver</button>
											</div>
	                                     </div>
									</c:forEach> 
                               	</div>
                           </div>
                       </div>
                </li>
     </ul>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span id="close">&times;</span>
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
				    <input type="hidden" id="numero" name="numero" >
				   <div class="mb-3">
				    <label for="dated" class="form-label">Date Start</label>
				    <input type="date" class="form-control" id="dated" aria-describedby="emailHelp" name="dated" required>
				  </div>
				   <div class="mb-3">
				    <label for="datef" class="form-label">Date End</label>
				    <input type="date" class="form-control" id="datef" aria-describedby="emailHelp" name="datef" required>
				  </div>
				    <input type="hidden" name="prixtotal" id="prixtotal">
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



function showmodal(numero , prix){
	var modal = $("#myModal");
	var span = $("#close");
		
			$("#numero").val(numero);
			$("#prixtotal").val(prix);
			console.log($("#prixtotal").val());
			console.log($("#numero").val());
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
                nom : $('#nom').val(),
                prenom : $('#prenom').val(),
                cin : $('#cin').val(),
                telephone :$('#telephone').val(),
                prixtotal :$('#prixtotal').val()*diff,
                numero : $('#numero').val(),
                dated :$('#dated').val(),
               	datef :$('#datef').val()
            },
            url : '/HotelWeb/Home',
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
            		navigator.clipboard.writeText(result);
	            	  swal({
	            		  title: "Good job!",
	            		  text: "Ton jeton est "+result+", il est copié vers votre presse-papier, garde le !",
	            		  icon: "success",
	            		  button: "D'accord",
	            		}).then(() => {
	                 	// window.location.replace("http://localhost:8081/HotelWeb/Home");
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