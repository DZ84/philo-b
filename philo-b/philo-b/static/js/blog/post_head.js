function create_subcomment_form(parent_nr) {
	var parent_element = document.getElementById("comment_" + parent_nr)
	var button_area = parent_element.getElementsByClassName("button-container")[0]

	var new_subcomment = create_new_subcomment(parent_nr)

	parent_element.insertBefore(
		new_subcomment,
		button_area
	)

	delete_create_buttons(button_area, parent_nr)
	set_submit_actions(new_subcomment)

	return new_subcomment
}

function create_new_subcomment(parent_nr) {
	var new_subcomment = document.getElementById("form_default").cloneNode(true)
	new_subcomment.id = "reply_to_" + parent_nr

	var new_textarea = new_subcomment.querySelector("textarea")
	new_textarea.id = "text_area_" + parent_nr
	new_textarea.value = "" 

	var new_input_all = new_subcomment.querySelectorAll("input")

	var new_input_csrf = new_input_all[0]
	new_input_csrf.value = document.getElementsByName('csrfmiddlewaretoken')[0].value

	var new_input_info = new_input_all[1]
	new_input_info.id = "parent_comment_" + parent_nr
	new_input_info.value = parent_nr

	var new_error_info = new_subcomment.querySelectorAll("ul")[0]
	new_error_info.id = "submit_errors_" + parent_nr
	clear_previous_errors(new_error_info)

	return new_subcomment
}

function delete_create_buttons(button_area, parent_nr) {
	button_area.querySelector('a').remove()

	var new_submit_button = document.createElement('BUTTON')

	new_submit_button.addEventListener('click', function() {
		submit_subcomment_form(parent_nr)
	})

	new_submit_button.className = "submit"
	new_submit_button.innerHTML = "submit"

	button_area.appendChild(new_submit_button)
}

function set_submit_actions(form_element) {
	form_element.submit = function() {
		data = standardize_form(this)
		do_ajax(data, this.action)
	}
}

function standardize_form(form_section) {
	text_area = form_section.querySelectorAll('textarea')[0]
	parent_comment_id = form_section.querySelectorAll('input')[1]
	comments_amount = document.getElementById('comments_amount')

//////////
	console.log(comments_amount.value)

	data = 'text_area=' + text_area.value +
		   '&parent_comment_id=' + parent_comment_id.value +
		   '&comments_amount_prev=' + comments_amount.value

	return data
}

function do_ajax(data, url) {
	var xhttp = new XMLHttpRequest();
	setup_reception_response(xhttp)
	sent_ajax(xhttp, data, url)
}

function setup_reception_response(xhttp) {
	xhttp.onreadystatechange = function() {
		if (this.readyState==4 && this.status==200) {
			handle_response(this.responseText)
		}
	}
}

function handle_response(response) {
	data = JSON.parse(response)

	console.log('receiving')

	if (data.success && data.reload) {
		location.reload(true)

	} else if (data.success) {
		var placing_parent = document.getElementById('comments_container')

		if (data.parent_id == 'default') {
			var placing_spot = document.getElementById('comment_' + data.parent_id)
			placing_comment(data.comment_object, placing_parent, placing_spot)

			var error_fields = document.getElementById('submit_errors_' + data.parent_id)
			clear_previous_errors(error_fields)
			placing_spot.querySelector('textarea').value = ''

		} else {
			var placing_spot = document.getElementById('clearing_' + data.parent_id)
			placing_comment(data.comment_object, placing_parent, placing_spot)

			var old_comment = document.getElementById('comment_' + data.parent_id)
			old_comment.getElementsByClassName('submit')[0].remove()
			old_comment.querySelector('form').remove()
		}
		
		comments_amount = document.getElementById('comments_amount')
		console.log(comments_amount.value)
		comments_amount.value = parseInt(comments_amount.value) + 1
		console.log(comments_amount.value)

		var button_data = { 'id': data.comment_object.id }
		placing_button(button_data)

	} else if (data.messages.length>0) {
		var error_fields = document.getElementById('submit_errors_' + data.parent_id)
		clear_previous_errors(error_fields)
		display_errors(data.messages, data.parent_id)

	} else {

		// bad things..

	}
}

function placing_comment(comment_data, placing_parent, placing_spot) {
	var template = document.getElementById('comment_template').innerHTML
	var text_html = fill_template(template, comment_data)
	var new_comment_coll = convert_text_html_collection(text_html)

	placing_parent.insertHTMLCollectionBefore(
		new_comment_coll,
		placing_spot
	)
}

function placing_button(button_data) {
	var template = document.getElementById('button_template').innerHTML
	var comment = document.getElementById('comment_' + button_data.id) 

	var text_html = fill_template(template, button_data)
	var new_button_coll = convert_text_html_collection(text_html)
	comment.appendChild(new_button_coll[0])
}

function display_errors(messages, error_id) {
	var error_field = document.getElementById('submit_errors_' + error_id)

	for(var i=0; i<messages.length; i++) {
		var error_item = document.createElement('li')
			error_item.innerHTML = messages[i]
			error_field.appendChild(error_item)
	}
}

function sent_ajax(xhttp, data, url) {
	xhttp.open('POST', url, true)
	xhttp.setRequestHeader('X-CSRFToken', document.getElementsByName('csrfmiddlewaretoken')[0].value)
	xhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8')
	xhttp.send(data)
}

function submit_comment_form() {
	document.getElementById("form_default").submit()
}

function submit_subcomment_form(parent_nr) {
	document.getElementById("reply_to_" + parent_nr).submit()
}

function clear_previous_errors(error_fields) {
	while(error_fields.lastChild) {
		error_fields.removeChild(error_fields.lastChild)
	}
}

Element.prototype.insertHTMLCollectionBefore = function(node_list, child_node) {
	while(node_list.length>0) {
		this.insertBefore(
			node_list[0],
			child_node
		)}
}

function fill_template(template, data) {
	for (key in data) {
		var pattern = '{:' + key + ':}'
			var regex = new RegExp(pattern, 'g')
			template = template.replace(regex, data[key])
	}
	return template
}

function convert_text_html_collection(text_html) {
	var mock_div = document.createElement('div')
	mock_div.innerHTML = text_html
	var node_list = mock_div.children

	return node_list
}
