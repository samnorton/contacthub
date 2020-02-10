
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require jquery-ui
//= require toastr
//= require_tree .

$(document).on('turbolinks:load', function () {

  // Scrolling Nav
  $(".nav-link").click(function () {
    var topData = $('#' + $(this).attr("data-id")).offset();
    $('html, body').animate({
      scrollTop: topData.top
    }, 'slow');
  });


 // Toastr Notification
 toastr.options = {
  "closeButton": true,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "preventDuplicates": true,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}


// Add active-menu class on sliding menus
var url = window.location.href;
var link = window.location.hash
$('a.js-nav.active-menu').removeClass('active-menu');
$('a.js-nav[data-id="' + link.replace('#', '') + '"]').addClass('active-menu'); 



  // Add Category Button
  $(document).on('click', '#add-category-btn', function () {
    $("#add-new-category").slideToggle(function () {
      if ($('#add-new-category').hasClass('hide') == true) {
        $('#add-new-category').addClass('flex').removeClass('hide');
      }else {
        $('#add-new-category').removeClass('flex').addClass('hide');
      }
    });
    return false;
  });

  //Save new category while creating the form
  $(document).on('click', '#save-new-category-btn', function(e) {
    e.preventDefault();

    $.ajax({
      url: '/categories',
      method: 'post',
      data: {
        category: { name: capitalizeFirstLetter($('#new-category').val()) }
      },
      success: function (category) {
        if (category.id != null) {
          let newOption = $('<option/>')
            .attr('value', category.id)
            .attr('selected', true)
            .text(category.name)

          $('#category_select').append(newOption);
          $('#new-category').val('');
        }
      },
      error: function (xhr) {
        let errors = xhr.responseJSON;
      }

    });

   

  });



  //Open delete contact modal
  $(document).on('click', '.delete-contact', function(){
    $('#confirm-modal').modal('show');
    contact_id = $(this).data('id');
  });

  //Send AJAX request to delete specific record when user confirms the action
  $(document).on('click', '.confirm-delete', function(){
    $.ajax({
      url: '/dashboard/contacts/' + contact_id,
      method: 'delete',
      data: {
        contact: contact_id
      },
      success: function (category) {
      },
      error: function (xhr) {
        let errors = xhr.responseJSON;
      }
    });
  });

  // Open the file browser when our custom button is clicked.
  $(document).on('click', '.input-file .btn', function () {
    $(this).siblings('input[type="file"]').trigger('click');

    $('input[type="file"]').change(function (e) {
      // Get this file input value
      var val = $('input[type="file"]').val();

      // Let's only show filename.
      // By default file input value is a fullpath, something like
      // C:\fakepath\Nuriootpa1.jpg depending on your browser.
      var filename = val.replace(/^.*[\\\/]/, '');

      // Display the filename
      $('input[type="file"]').siblings('.file-selected').text(filename);
    });
  });

  $(function () {
    $('#term').autocomplete({
      source: '/dashboard/contacts/autocomplete',
      minLength: 3,
      select: function (event, ui) {
        $('#term').val(ui.item.value);
        $(this).closest('form').submit();
      }
    });
  });








});



function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
}

// when back button was click we will run the url that was click previously
$(window).on('popstate', function () {
  $.get(document.location.href);
});



