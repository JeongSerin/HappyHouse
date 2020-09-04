<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
   String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title>Main Map</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA4I_BiJMIBEq9xbUZlLXzapBGMTTYZqV0&callback=getMapData"></script>

<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */

#map {
   height: 400px;
   width: 95%;
   margin: auto;
   margin-top: 10px;
}
/* Optional: Makes the sample page fill the window. */

</style>
   
</head>
<body>
    <div id="map"></div>
   
    <script>

    var INFO_WINDOW_HTML = 
       '<div class="card" style="width:200px">' +
      '<div class="card-body">' +
      '<h4 class="card-title">^APT_NAME</h4>' +
      '<p class="card-text">^DONG</p>' +
      '<p class="card-text">지번: ^JIBUN</p>' +
      '<p class="card-text">건축년도: ^BUILDYEAR</p>' +
      '</div>' +
      '</div>';
      
    function initMap() {

      var map = new google.maps.Map(
         document.getElementById('map'), 
         {
              zoom: 13,
              center: {
                 lat: parseFloat(locations[0].lat), lng: parseFloat(locations[0].lng)
//                 lat: parseFloat(locations[0].lat), lng: parseFloat(locations[0].lng)
              }
            }
      );

      var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var markers = locations.map(

         function(location, i) {
              return new google.maps.Marker(
                 {
                      position: { lat: parseFloat(location.lat), lng: parseFloat(location.lng) },   // should be float, not string
                      label: labels[i % labels.length],
                      aptName: location.aptName,
                      dong: location.dong,
                      jibun: location.jibun,
                      buildYear: location.buildYear
                 }
              );
            }
      );

      var markerCluster = new MarkerClusterer(
         map,
         markers,
         {
            imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
         }
      );
      
      
      markers.map(
         function(marker, i){
            marker.addListener('click', function() {
               var infowindow = new google.maps.InfoWindow({
                   content: INFO_WINDOW_HTML.replace('^APT_NAME', marker.aptName).replace('^DONG', marker.dong).replace('^BUILDYEAR', marker.buildYear).replace('^JIBUN', marker.jibun)
               });
               infowindow.open(map, marker);
            });
         }
      );
    }
    
   var locations;

   function getMapData(){

      $.ajax(
      {
           type : 'post',
           url : '<%=contextPath%>/housedealList',
           dataType : 'json',
           success : function(data) {
              locations = data;
              initMap();
           }, 
           error: function(jqXHR, textStatus, errorThrown) 
           { 
              alertify.notify(
                    'Opps!! 글 Map data를 받는 과정에 문제가 생겼습니다.', 
                    'error', //'error','warning','message'
                    3, //-1
                    function(){
                       console.log(jqXHR.responseText); 
                    }
                 );
           }
       });
   }
    </script>
  </body>
</html>
