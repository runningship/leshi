

$(window).load(function() {
 //Image Hover Efect
 $(".loading").fadeOut(1000); 	
});



$(document).ready(function() {
  
  //--------------------------scrollTo------------------------------//  
      
  $(".navUl li").hover(function(){
	 $(this).children(".down_menu").toggle(); 
	 $(this).children("a").toggleClass("hover");
  });
  
  
  //--------------------------Nivo Slider--------------------------//
  $('#slider').nivoSlider({
        effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
        slices: 15, // For slice animations
        boxCols: 8, // For box animations
        boxRows: 4, // For box animations
        animSpeed: 500, // Slide transition speed
        pauseTime: 5000, // How long each slide will show
        startSlide: 0, // Set starting Slide (0 index)
        directionNav: true, // Next & Prev navigation
        directionNavHide: true, // Only show on hover
        controlNav: true, // 1,2,3... navigation
        controlNavThumbs: false, // Use thumbnails for Control Nav
        controlNavThumbsFromRel: false, // Use image rel for thumbs
        controlNavThumbsSearch: '.$pg', // Replace this with...
        controlNavThumbsReplace: '_thumb.$pg', // ...this in thumb Image src
        keyboardNav: false, // Use left & right arrows
        pauseOnHover: true, // Stop animation while hovering
        manualAdvance: false, // Force manual transitions
        captionOpacity: 1, // Universal caption opacity
        prevText: 'Prev', // Prev directionNav text
        nextText: 'Next', // Next directionNav text
        beforeChange: function(){}, // Triggers before a slide transition
        afterChange: function(){}, // Triggers after a slide transition
        slideshowEnd: function(){}, // Triggers after all slides have been shown
        lastSlide: function(){}, // Triggers when last slide is shown
        afterLoad: function(){} // Triggers when slider has loaded
    });
	  
  //--------------------------Zoombox------------------------------//  

  
   
	
});