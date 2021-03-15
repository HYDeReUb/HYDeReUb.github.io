var x=1;
var x1=1;
     function myFunction(){
          if(x==1){
          document.getElementById('myImage').src='pic_bulbon.gif'; 
              x=2;
          }
          else{
              document.getElementById('myImage').src='pic_bulboff.gif';
              x=1;
          }
      };
      function myFunction2(){
          if(x1==1){
          document.getElementById("demo2").innerHTML="Holl Kun Shan University";
              x1=2;
          }
          else{
              document.getElementById('demo2').innerHTML='';
              x1=1;
          }
      }
      function myFunction3(){
           document.getElementById('demo').style.fontSize='35px';
      }
      