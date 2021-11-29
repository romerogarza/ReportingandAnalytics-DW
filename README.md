# How to contribute

Third-party patches are essential for keeping Puppet great. We simply can't
access the huge number of platforms and myriad configurations for running
Puppet. We want to keep it as easy as possible to contribute changes that
get things working in your environment. There are a few guidelines that we
need contributors to follow so that we can have a chance of keeping on
top of things.

## Puppet Core vs Modules

New functionality is typically directed toward modules to provide a slimmer
Puppet Core, reducing its surface area, and to allow greater freedom for
module maintainers to ship releases at their own cadence, rather than
being held to the cadence of Puppet releases. With Puppet 4's "all in one"
packaging, a list of modules at specific versions will be packaged with the
core so that popular types and providers will still be available as part of
the "out of the box" experience.

Generally, new types and new OS-specific providers for existing types should
be added in modules. Exceptions would be things like new cross-OS providers
and updates to existing core types.

If you are unsure of whether your contribution should be implemented as a
module or part of Puppet Core, you may visit [#puppet-dev on slack](https://puppetcommunity.slack.com/), or ask on
the [puppet-dev mailing list](https://groups.google.com/forum/#!forum/puppet-dev) for advice.