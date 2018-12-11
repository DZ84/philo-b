from django import forms

from .models import Comment


class CommentForm(forms.Form):

	parent_comment_id = forms.IntegerField(
		widget=forms.HiddenInput(),
		required=False,
		initial=None
	)

	# other_texts = forms.CharField(
	# 	widget=forms.HiddenInput(),
	# 	required=False,
	# 	initial=None
	# )

	text_area = forms.CharField(
		# min_length = 10,
		label='',
		widget=forms.Textarea(
			attrs={
				'class': 'text_area',
				'id': 'text-area-0',
				# 'placeholder': 'write your message here'
			},
		)
	)

