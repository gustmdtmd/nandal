function init(chk){
   console.log("init chk=>" + chk);
   
   if(chk){
     $('.pbx top3').removeClass('hidePage').addClass('showPage');
     $('.pbx top4').removeClass('showPage').addClass('hidePage');
   }else{
     $('.pbx top3').removeClass('showPage').addClass('hidePage');
     $('.pbx top4').removeClass('hidePage').addClass('showPage');
   }
}