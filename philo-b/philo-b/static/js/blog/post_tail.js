// - pure js implementation of code that should run 
//   once the dom (not page) is loaded.
// - you could perhaps run it once the user presses
//   the button, but why wait?
(function() {
	form_section = document.getElementById("comment-default")

	console.log('initialized submit method')
	console.log("we went here")

	form_section.submit = function() {

		console.log('submitted started')

		data = standardize_form(this)	
		do_ajax(data, this.action)
	}
	console.log('but did we go here?')
	
})()

