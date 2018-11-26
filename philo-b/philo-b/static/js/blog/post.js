// function set_submit_states(saved_textareas) {
// 
// 	for(var i = 0; i < saved_textareas.length; i++) {
// 		parent_nr = saved_textareas[i].id
// 		saved_text = saved_textareas[i].text
// 
// 		create_subcomment_form(parent_nr) 
// 
// 		text_area = document.getElementById("text-area-" + parent_nr)
// 		text_area.value = saved_text
// 		
// 	}
// 
// }


function set_previous_submits(ej) {

	for(var i = 0; i < ej.length; i++) {
		parent_nr = ej[i].id
		error_messages = ej[i].messages

		create_subcomment_form(parent_nr) 

		error_ul = document.getElementById("submit-errors-" + parent_nr)

		for(var m = 0; m < error_messages.length; m++) {
			var error_li = document.createElement('LI')
			error_li.innerHTML = error_messages[m]

			error_ul.appendChild(error_li)
		}
	}
}

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


	// return new_subcomment
}

function create_new_subcomment(parent_nr) {
	// -create form by cloning
	// -give correct id_parent_comment to prevent duplicate id's
	// -clear textarea from cloned form
	// -csrf token value is not copied with the cloning
	// -adjust info value as it will be used upon submission

	new_subcomment = document.getElementById("comment-default").cloneNode(true)
	new_subcomment.id = "reply-to-" + parent_nr

	new_textarea = new_subcomment.querySelectorAll("textarea")[0]
	new_textarea.id = "text-area-" + parent_nr
	new_textarea.value = "" 

	new_input_all = new_subcomment.querySelectorAll("input")

	new_input_csrf = new_input_all[0]
	new_input_csrf.value = document.getElementsByName('csrfmiddlewaretoken')[0].value

	new_input_info = new_input_all[1]
	new_input_info.id = "parent-comment-" + parent_nr
	new_input_info.value = parent_nr	

	new_error_info = new_subcomment.querySelectorAll("ul")[0]
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
}

