# About

A set of tools (shell scripts) to extend [daemontools](http://cr.yp.to/daemontools.html) services.

What it does:
 * Almost generically: run your services in the same way.
 * Can make services wait on others before starting.
 * Notify hipchat, when a service starts, stops, or is waiting for another
 service to start.
 * Save a pid file with the pid of the running process, and delete it at the end.
  
# Example

    ~$ git clone git@github.com:marcelog/daemontools-tools.git
    ~$ cd daemontools-tools
    ~/daemontools-tools$ cp config.example config
    ~/daemontools-tools$ vim config
    
There's a simple service sample in the [sample.service](https://github.com/marcelog/daemontools-tools/tree/master/sample.service) directory. 
