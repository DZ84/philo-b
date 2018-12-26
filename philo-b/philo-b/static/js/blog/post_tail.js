// - pure js implementation of code that should run 
//   once the dom (not page) is loaded.
// - you could perhaps run it once the user presses
//   the button, but why wait?
(function() {
	form_element = document.getElementById("form_default")
	set_submit_actions(form_element)
})()

