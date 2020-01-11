
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
//= require_tree .

$(document).on('turbolinks:load', function(){

  // Scrolling Nav
  $(".nav-link").click(function(){
      var topData = $( '#' + $(this).attr("data-id")).offset();
      $('html, body').animate({
          scrollTop: topData.top
      }, 'slow');
     });
  
  
     // Add Category Button
     $("#add-new-category").hide();
     $('#add-category-btn').click(function () {      
       $("#add-new-category").slideToggle(function() {
         $('#new_group').focus();
       });
       return false;
     });
  
     $('#save-new-category-btn').click(function(event) {
  
         event.preventDefault();
  
         $.ajax({
           url: '/categories',
           method: 'post',
           data: {
             category: { name: $('#new-category').val() }
           },
           success: function(category){
              // console.log(response);
              if(category.id != null){
                let newOption = $('<option/>')
                .attr('value', category.id)
                .attr('selected', true)
                .text(category.name)
  
                $('#category_select').append(newOption);
                $('#new-category').val('');
              }
           },
           error: function(xhr){
             let errors = xhr.responseJSON;
           }
  
         });
     });


     $('input[type="file"]').each(function() {
      // get label text
      var label = $(this).parents('.form-group').find('label').text();
      label = (label) ? label : 'Upload File';
  
      // wrap the file input
      $(this).wrap('<div class="input-file"></div>');
      // display label
      $(this).before('<span class="btn">'+label+'</span>');
      // we will display selected file here
      $(this).before('<span class="file-selected"></span>');
  
      // file input change listener 
      $(this).change(function(e){
          // Get this file input value
          var val = $(this).val();
          
          // Let's only show filename.
          // By default file input value is a fullpath, something like 
          // C:\fakepath\Nuriootpa1.jpg depending on your browser.
          var filename = val.replace(/^.*[\\\/]/, '');
  
          // Display the filename
          $(this).siblings('.file-selected').text(filename);
      });
  });
  
  // Open the file browser when our custom button is clicked.
  $('.input-file .btn').click(function() {
      $(this).siblings('input[type="file"]').trigger('click');
  });
  

  });
  
  