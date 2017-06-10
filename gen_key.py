
from random import choices
from string import ascii_uppercase, ascii_lowercase, digits

print(''.join(choices(ascii_uppercase + ascii_lowercase + digits, k=25)))

