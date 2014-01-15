TERC Puppet BIND Library
=======

####Table of Contents

1. [Overview - What is the bindlib module?](#overview)
2. [Why - Reasoning for developing this module ](#why?)
3. [Implementation - Summary of the under the hood implementation of the module ](#implementation)
4. [Limitations - Known issues and limitations of the implementation ](#limitations)
5. [Contributing](#contributing)

Overview
--------

TERC's bindlib module is a BIND centric library which provides the dns_zone and dns_rr types as well as a number of ancillary functions:
- two versions of the $GENERATE directive:  one which returns values for your own use and one which creates the resources
- IDNA functions to convert from unicode to ascii punycode and encode/decode either.

We also include some examples and templates.

Manifest code and any templates that are included are intended to be an example/starting point only and may change at 
any time for any reason.  If you use them, it is recommended that you create your own module so that updates to 
this module do not break your kit.

Why?
--------
For something as critical as DNS, puppet does a pretty horrid job of managing it by default.  You're left to cook up your 
own thing, probably using templates, (ab)use of the $INCLUDE directive, and possibly an exec - and even that will probably
leave you wanting.  Or maybe you register things in LDAP, I don't know.  The fact is if you were happy with how things are
you wouldn't be reading this... and now I'm a bit confused as to why I felt the need to include a justification for its existence.

Implementation
--------



Limitations
--------
Property fix is called via send on object creation.  This may create a security issue when a file is first created if the properties are
not correctly set, although this should get fixed on the next puppet run.

Does not respect resource record classes.

Contributing
-------
Feel free to contact me(cammoraton) directly or submit a pull request.  I also hang out on IRC an awful lot.
