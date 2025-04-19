import hashlib
import os
from binascii import b2a_base64
from hashlib import pbkdf2_hmac

def generate_pbkdf2_hash(password):
    # Generate a salt
    salt = os.urandom(16)
    
    # PBKDF2 parameters
    iterations = 600000
    hash_name = 'sha512'

    # Generate the PBKDF2 hash
    password_hash = pbkdf2_hmac(hash_name, password.encode('utf-8'), salt, iterations)

    # Convert the salt and hash to base64 for readability
    salt_base64 = b2a_base64(salt).decode('utf-8').strip()
    hash_base64 = b2a_base64(password_hash).decode('utf-8').strip()

    # Format the result in the $pbkdf2-sha512$ format
    result = f"$pbkdf2-sha512${iterations}${salt_base64}${hash_base64}"

    return result

# Prompt user to enter a password
if __name__ == "__main__":
    password = input("Enter the password to hash: ")  # User input
    hash_result = generate_pbkdf2_hash(password)
    print("Generated Hash:", hash_result)
