TERC Puppet Bind Library
=======

####Table of Contents

1. [Overview - What is the bindlib module?](#overview)
2. [Why - Reasoning for developing this module ](#why?)
3. [Implementation - Summary of the under the hood implementation of the module ](#implementation)
4. [Limitations - Known issues and limitations of the implementation ](#limitations)
5. [Contributing](#contributing)

Overview
--------

The bindlib module provides the zone_file and resource_record types as well as a few associated functions.

Manifest code that is included is intended to be an example/starting point only.  If you use it, it is
recommended that you fork it off into it's own module so that you may update the base providers/types
in isolation.

Why?
--------
I thought:
- It would be nice if nodes could register themselves automatically in DNS
- Without having to do silly things like use LDAP
- And with actual view support

Implementation
--------



Limitations
--------
Property fix is called via send on object creation.  This may create a security issue when a file is first created if the properties are
not correctly set, although this should get fixed on the next puppet run.

Does not respect resource record classes.

Contributing
-------
Feel free to contact me directly or submit a pull request.  I also hang out on IRC an awful lot.
