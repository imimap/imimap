// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery-ui/widgets/slider
//= require jquery_ujs
//= require jquery_nested_form
//= require chosen-jquery
//= require d3
//= require stupidtable.min
//= require bootstrap
//= require bootstrap.min
//= require_tree .

// jquery for smooth scroll test
// Select all links with hashes
$('a[href*="#"]')
// Remove links that don't actually link to anything
    .not('[href="#"]')
    .not('[href="#0"]')
    .click(function(event) {
        // On-page links
        if (
            location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
            &&
            location.hostname == this.hostname
        ) {
            // Figure out element to scroll to
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            // Does a scroll target exist?
            if (target.length) {
                // Only prevent default if animation is actually gonna happen
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: target.offset().top
                }, 1000, function() {
                    // Callback after animation
                    // Must change focus!
                    var $target = $(target);
                    $target.focus();
                    if ($target.is(":focus")) { // Checking if the target was focused
                        return false;
                    } else {
                        $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
                        $target.focus(); // Set focus again
                    };
                });
            }
        }
    });

// jquery for dropdown

(function($) { // Begin jQuery
    $(function() { // DOM ready
        // If a link has a dropdown, add sub menu toggle.
        $('nav ul li a:not(:only-child)').click(function(e) {
            $(this).siblings('.navigation-dropdown').toggle();
            // Close one dropdown when selecting another
            $('.navigation-dropdown').not($(this).siblings()).hide();
            e.stopPropagation();
        });
        // Clicking away from dropdown will remove the dropdown class
        $('html').click(function() {
            $('.navigation-dropdown').hide();
        });
        // Toggle open and close nav styles on click
        $('#navigation-toggle').click(function() {
            $('nav ul').slideToggle();
        });
        // Hamburger to X toggle
        $('#navigation-toggle').on('click', function() {
            this.classList.toggle('active');
        });
    }); // end DOM ready
})(jQuery); // end jQuery

// sampe sini


$(window).load(function () {
      // $(".alert-info").animate({opacity: 1.0}, 5000).fadeOut('slow');

      $("#close").click(function(){
        $(".msgbox").fadeOut("400");
        $.cookie('fadeOut', true);
      });
    // hide the message box if the close already clicked before
    //  if($.cookie('fadeOut') == 'true'){
     //   $(".msgbox").hide();
    // } else {
    //     $('.msgbox').click();
    //  }

    $(".edit-rating .rating_star").click(function() {
      var val = $(this).attr('data-rating-id');
      var id = $(this).parent().parent().attr("id");
      setStars(val, id);
      setValue(val, id);
    });

  var setStars = function(val, id) {
    stars = $("#"+id+" .rating_star");
    $(stars).each(function(){
      var currentId = $(this).attr('data-rating-id');
      if (currentId <= val)
        $(this).addClass('on')
      else
        $(this).removeClass('on')
    })
  }

  var setValue = function(val, id) {
    $("#internship_internship_rating_attributes_"+id).val(val);
  }

});

$(document).ready(function() {
     $("#hide_all").click(function () {
     $(".answer").slideToggle("slow");
     $(".comment").slideToggle("slow");
     $(".answer_2").slideToggle("slow");
     $("#comment_form").slideToggle("slow");
  });
     $(".info_signup").hide();
     $(".icon-info-sign").mouseover(function(){
       $("#popup").fadeIn("slow");
     });
     $(".icon-info-sign").mouseleave(function(){
       $("#popup").fadeOut("slow");
     });

  $(".recommend-edit").click(function() {
      $(this).toggleClass( "icon-thumbs-up" );
      $(this).toggleClass( "green-thumb" );
      $(this).toggleClass( "icon-thumbs-down" );
      $(this).toggleClass( "red-thumb" );
      toggle_value("#internship_recommend");
  });

  $(".recommend-publicmail").click(function() {
      $(this).toggleClass( "icon-thumbs-up" );
      $(this).toggleClass( "green-thumb" );
      $(this).toggleClass( "icon-thumbs-down" );
      $(this).toggleClass( "red-thumb" );
      toggle_value("#user_publicmail");
  });

  $(".recommend-mailnotif").click(function() {
      $(this).toggleClass( "icon-thumbs-up" );
      $(this).toggleClass( "green-thumb" );
      $(this).toggleClass( "icon-thumbs-down" );
      $(this).toggleClass( "red-thumb" );
      toggle_value("#user_mailnotif");
  });

  toggle_value = function(id) {
    var elem =  $(id);
    var value = elem.val();
    if (value === "0") {
      elem.val("1");
    } else if (value === "1") {
      elem.val("0");
    }
  }


});

click_reset = function() {
  $(".chzn-select").val('').trigger("liszt:updated");
  $(".search-choice").remove();
  $("#search_button").click();
}
