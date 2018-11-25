from django import forms

from .models import Comment

# from django.core.exceptions import ValidationError
# 
# 
# def validate_not_empty(value):
# 	import re
# 	
# 	# import pdb
# 	# pdb.set_trace()
# 
# 	if not (re.match('\w+', value)):
# 		raise ValidationError('no message to submit')

class CommentForm(forms.Form):
   
    parent_comment_id = forms.IntegerField(
        widget=forms.HiddenInput(),
        required=False,
		initial=None
    )

    text_area = forms.CharField(
		# min_length = 10,
		# validators = [validate_not_empty],
        label='',
        widget=forms.Textarea(
			attrs={
				'class': 'text_area',
				# 'placeholder': 'write your message here'
			},
		)
    )

