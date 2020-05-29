# TCLOCK
#### A simple command line time tracking tool using bash and a plain text file
tclock is a bash script that facilitates tracking time in the [timeclock](https://hledger.org/timeclock.html) format

### Why?
Tracking time can be quite hard at first but once you get it as a habbit it's a great way to increase productivity and focus, especially when combined with other productivity techniques such as GTD, Pommodoro et al.
tclock uses the plain text [timeclock](https://hledger.org/timeclock.html) format so it's super portable, UNIX friendly and can be easily managed seperately from tclock with your favourite text editor.

### Features
- [x] Stop/start logging
- [ ] Reporting
- [ ] Searching
- [ ] Charting

### Pre-requisites
- Bash

### Installing
````
curl -L https://raw.githubusercontent.com/RobBollons/tclock/master/tclock > ./tclock && chmod +x ./tclock

# Place the 'tclock' file to somewhere in your PATH for convenience
# and maybe add a quick alias to your .bashrc/.zshrc like so:

echo 'alias tc=tclock' >> ~/.bashrc
````

### Usage
````
usage: tclock [action]

tclock - a simple command line time tracker

ACTIONS
   i|start     <description>              Update an existing entry to add additional fields to
   o|stop                                 Remove an entry from the password database
````

The default location of the timeclock file is '~/log.timeclock' however this can be overridden using the TCLOCK_FILE env variable. So for example you could put this in your .bashrc:
````
export TCLOCK_FILE='~/Google Drive/log.timeclock'
````

### Automated Tests (todo)

### Useful links
- [hledger](https://hledger.org/timeclock.html) - Plain text accounting tool that supports the timeclock format
- [timeclock.el](https://www.emacswiki.org/emacs/TimeClock) - TimeClock in emacs
