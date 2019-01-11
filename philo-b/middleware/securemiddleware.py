# securemiddleware.py
from secure import SecureHeaders

secure_headers = SecureHeaders()

def set_secure_headers(get_response):
    def middleware(request):
        response = get_response(request)
        secure_headers.django(response)
        return response

    return middleware

