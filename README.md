# Cobol Autoinc

Simplest marginally-useful web service imaginable: Auto-incrementing ID generator.

The Vagrant VM will provision itself with all the tools you need. You'll need to ssh into it, check out this project there, and compile the code.
Once you've compiled the `autoinc.cgi` file, you call it as a CGI script.
The easiest thing is to put it in `/home/vagrant/public_html`, and call it as either

    curl -si http://localhost/~vagrant/cobol/autoinc.cgi  # from the VM

or

    curl -si http://localhost:9080/~vagrant/cobol/autoinc.cgi  # from the host machine

To compile:
```
cobc -x -free -o autoinc.cgi autoinc.cbl
```
