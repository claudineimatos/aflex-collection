#
# Copyright 2014, Mischa Peters <mpeters AT a10networks DOT com>, A10 Networks.
# Version 1.0 - 20140204
#
# aFleX script to do redirection with a class-list.
#
# The class-list for the redirects is called
# "cl-uris" (default) of type "string" and has
# to contain the following data:
# str <uri>
#
# For example:
# str /uri1
# str /uri2
#
# Scalability of this aFleX is unknown.
#

when RULE_INIT {
    set ::DEBUG 0
    set ::CLASSLIST "cl-uris"
}

when HTTP_REQUEST {
    set URI [string tolower [HTTP::uri]]
    if { [CLASS::match $URI starts_with $::CLASSLIST] == 1 } {
        HTTP::redirect http://[HTTP::host]
        if { $::DEBUG == 1 } { log "Redirected: $URI" }
    }
}
