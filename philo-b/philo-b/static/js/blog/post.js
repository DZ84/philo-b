function create_subcomment_form(parent_nr) {

	var new_subcomment = create_new_subcomment(parent_nr)

	var parent_element = document.getElementById("comment-" + parent_nr)
	var new_subcomment_buttons = parent_element
		.getElementsByClassName("button-container")[0]

	parent_element.insertBefore(
		new_subcomment,
		new_subcomment_buttons
	)

	delete_create_buttons(new_subcomment_buttons, parent_nr)

	return new_subcomment
}

function create_new_subcomment(parent_nr) {
	// -create form by cloning
	// -give correct id_parent_comment to prevent duplicate id's
	// -clear textarea from cloned form
	// -csrf token value is not copied with the cloning
	// -adjust info value as it will be used upon submission

	var new_subcomment = document.getElementById("comment-default").cloneNode(true)
	new_subcomment.id = "reply-to-" + parent_nr

	var new_textarea = new_subcomment.querySelectorAll("textarea")[0]
	new_textarea.id = "text-area-" + parent_nr
	new_textarea.value = "" 

	var new_input_all = new_subcomment.querySelectorAll("input")

	var new_input_csrf = new_input_all[0]
	new_input_csrf.value = document.getElementsByName('csrfmiddlewaretoken')[0].value

	var new_input_info = new_input_all[1]
	new_input_info.id = "parent-comment-" + parent_nr
	new_input_info.value = parent_nr

	var new_input_other_texts = new_input_all[2]
	new_input_other_texts.id = "other-texts-" + parent_nr

	var new_error_info = new_subcomment.querySelectorAll("ul")[0]
	new_error_info.id = "submit-errors-" + parent_nr

	return new_subcomment
}

function delete_create_buttons(new_subcomment_buttons, parent_nr) {
	// -remove reply button
	// -configure submit button
	// -insert submit button

	new_subcomment_buttons.getElementsByClassName('reply')[0].remove()

	var new_submit_button = document.createElement('BUTTON')

	new_submit_button.addEventListener('click', function() {
		submit_subcomment_form(parent_nr)
	})
	new_submit_button.className = "submit"
	new_submit_button.innerHTML = "submit"

	new_subcomment_buttons.appendChild(new_submit_button)
}

function submit_subcomment_form(parent_nr) {
	document.getElementById("reply-to-" + parent_nr).submit()
}

function submit_comment_form() {
	
	document.getElementById("comment-default").submit()

	// form_section = document.getElementById("comment-default")

	// // e.preventDefault()
	// form_data = standardize_form(form_section)	

	// sent_ajax(form_data)


}

function standardize_form(form_section) {
	text_area = form_section.querySelectorAll('textarea')[0]
	parent_comment_id = form_section.querySelectorAll("input")[1]

	// debugger

	form_data = new FormData()	
	form_data.append(text_area.name, text_area, text_area.name)
	form_data.append(parent_comment_id.name, parent_comment_id, parent_comment_id.name)

	return form_data
}

function sent_ajax(form_data, url) {
	var xhttp = new XMLHttpRequest()
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			console.log(xhttp.responseText)
			debugger
		}
	}
	// debugger
	xhttp.open('POST', url, true)
	xhttp.setRequestHeader('X-CSRFToken', document.getElementsByName('csrfmiddlewaretoken')[0].value)
	xhttp.setRequestHeader('Content-type','application/x-www-form-urlencoded')
	xhttp.send(form_data)
}



function test_ajax() {
	var xhttp = new XMLHttpRequest()
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			console.log(xhttp.responseText)
		}
	}

	xhttp.open('POST', get_url_ajax(), true)
	xhttp.setRequestHeader('X-CSRFToken', document.getElementsByName('csrfmiddlewaretoken')[0].value)
	xhttp.setRequestHeader('Content-type','application/x-www-form-urlencoded');
	xhttp.send('testtt=tester')
}

// pure js implementation of code that should run 
// once the dom (not page) is loaded.
(function() {
	form_section = document.getElementById("comment-default")
	console.log('started')

	// prevent submitting as usual of the form
	form_section.addEventListener('submit', function(event) {

		console.log('submitted started')

		event.preventDefault()
		form_data = standardize_form(this)	
		sent_ajax(form_data, this.action)
	})
})()

