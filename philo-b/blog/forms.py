from django import forms

from .models import Comment

class CommentForm(forms.Form):
   
    parent_comment_id = forms.IntegerField(
        widget=forms.HiddenInput(),
        required=False,
		initial=None
    )

    text_area = forms.CharField(
        label='',
        widget=forms.Textarea(attrs={
			'class': 'text_area'
			}
		)

    )


# from django.core.exceptions import ValidationError
# 
# def validate_not_empty(value):
# 	import re
# 	if not (re.match('\w+', value)):
		


