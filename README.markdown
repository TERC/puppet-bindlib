TERC Puppet Bind Library
=======

####Table of Contents

1. [Overview - What is the bindlib module?](#overview)
2. [Why - Reasoning for developing this module ](#why?)
3. [Implementation - Summary of the under the hood implementation of the module ](#implementation)
4. [Limitations - Known issues and limitations of the implementation ](#limitations)
5. [Release Notes - Notes on the most recent updates to the module](#release-notes)

Overview
--------

The bindlib module provides

No manifest code is included.  This is pretty much pure ruby code for inclusion in other modules.

Why?
--------
I thought:
- It would be nice if nodes could register themselves automatically in DNS
- Without having to do silly things like use LDAP
- And with actual view support

Implementation
--------
By extending the Puppet file type and using some providers we can merge templated or sourced content and modifications and
have puppet treat this content as if it had been passed directly.

The changes themeselves are applied via the XmlLens class, which fakes being augeas.  This is accomplished via the standard
ruby REXML library.  Upshot of this is we can add in things like sorting.

Limitations
--------
I don't have a complete windows puppet kit and so while we extend the windows provider and it should work, I can't actually 
test it.

Property fix is called via send on object creation.  This may create a security issue when a file is first created if the properties are
not correctly set, although this should get fixed on the next puppet run.

Release Notes
--------
####  v0.1.0
- Initial Release

