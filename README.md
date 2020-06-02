# TCLOCK
#### A simple command line time tracking tool using bash and a plain text file
tclock is a bash script that facilitates tracking time in the [timeclock](https://hledger.org/timeclock.html) format

### Why?
Tracking time can be quite hard at first but once you get it as a habbit it's a great way to increase productivity and focus, especially when combined with other productivity techniques such as GTD, Pommodoro et al.
tclock uses the plain text [timeclock](https://hledger.org/timeclock.html) format so it's super portable, UNIX friendly and can be easily managed seperately from tclock with your favourite text editor.

### Features
- [x] Stop/start logging
- [x] Basic Reporting
- [ ] Install script
- [ ] Searching
- [ ] Charting

### Pre-requisites
- bash
- GNU awk

### Installing
````
curl -L https://raw.githubusercontent.com/RobBollons/tclock/master/tclock > ./tclock && chmod +x ./tclock

# Place the 'tclock' file to somewhere in your PATH for convenience

# To get the reporting commands (print, summary and active) to work you need to download the tclock.awk file and add it to your AWKPATH
curl -L https://raw.githubusercontent.com/RobBollons/tclock/master/tclock.awk > ./tclock.awk

# If AWKPATH isn't defined you can just add it to your .bashrc/.zshrc and set it like you would the PATH variable e.g.
export AWKPATH=$AWKPATH:~/.local/awk/

````

### Usage
````
usage: tclock [action]

tclock - a simple command line time tracker

ACTIONS
    i|in|start     <description>      Begin tracking / Log time in entry
    o|out|stop                        Stop tracking / Log time out
    edit                              Launch default editor with the timeclock file
    print          <yyyy-mm-dd>       Prints all entries for a given date
    summary        <yyyy-mm-dd>       Prints a grouped summary of all entries for a given date
    active                            Prints a list of open time entries
````

The default location of the timeclock file is '~/log.timeclock' however this can be overridden using the TCLOCK_FILE env variable. So for example you could put this in your .bashrc:
````
export TCLOCK_FILE='~/Google Drive/log.timeclock'
````

### Automated Tests (todo)

### Useful links
- [hledger](https://hledger.org/timeclock.html) - Plain text accounting tool that supports the timeclock format
- [timeclock.el](https://www.emacswiki.org/emacs/TimeClock) - TimeClock in emacs
