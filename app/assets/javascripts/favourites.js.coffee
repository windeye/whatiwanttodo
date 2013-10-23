$(document).ready ->
	$("body").on "ajax:success", "#interactions [data-remote]", (e, data, status, xhr) ->
	    $(this).parents("#interactions").replaceWith(data)
	$("#interactions").on "ajax:error", (event, xhr, status,error) ->
	    if (xhr.status == 401)
            $("#interactions a").popover('destroy')
            $("#interactions a").popover({placement: 'left', content: "#{xhr.responseText}"}).popover('show')
            setTimeout ( -> $("#interactions a").popover('hide')), 3000
