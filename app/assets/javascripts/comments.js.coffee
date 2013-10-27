jQuery ->
  # Create a comment
  $("#comment-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      #$(xhr.responseText).hide().insertAfter($(this)).show('slow')
      $(xhr.responseText).hide().prependTo($("#all-comments")).show('slow')
    .on "ajax:error", (event, xhr, status,error) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      $(this).parents("#post-comment").removeAttr('disabled', 'disabled')
      if (xhr.status == 401 or xhr.status == 400)
        $("#post-comment").popover({content: "#{xhr.responseText}"}).popover('show')
        setTimeout (-> $("#post-comment").popover('destroy')), 3000
  $(document)
    .on "ajax:beforeSend", ".comment", ->
      $(this).fadeTo('fast', 0.5)
    .on "ajax:success", ".comment", ->
      $(this).hide('fast')
    .on "ajax:error", ".comment", ->
      $(this).fadeTo('fast', 1)
