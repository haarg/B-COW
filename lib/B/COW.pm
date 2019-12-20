package B::COW;

use strict;
use warnings;

# ABSTRACT: B::COW additional B helpers to check COW status

use base 'Exporter';

# VERSION: generated by DZP::OurPkgVersion

use XSLoader;

XSLoader::load(__PACKAGE__);

my @all_export = qw{ can_cow is_cow cowrefcnt cowrefcnt_max };

our @EXPORT_OK = (
    @all_export,
);

our %EXPORT_TAGS = (
    all => [@all_export],
);


1;
 __END__

=pod

=encoding utf-8

=begin markdown

[![](https://github.com/atoomic/B-COW/workflows/linux/badge.svg)](https://github.com/atoomic/B-COW/actions) [![](https://github.com/atoomic/B-COW/workflows/macos/badge.svg)](https://github.com/atoomic/B-COW/actions) [![](https://github.com/atoomic/B-COW/workflows/windows/badge.svg)](https://github.com/atoomic/B-COW/actions)

=end markdown

=head1 SYNOPSIS

# EXAMPLE: examples/synopsis.pl

=head1 DESCRIPTION

B::COW provides some naive additional B helpers to check the COW status of one SvPV.

=head2 COW or Copy On Write introduction

A COWed SvPV is sharing its string (the PV) with other SvPVs.
It's a (kind of) Read Only C string, that would be Copied On Write (COW).

More than one SV can share the same PV, but when one PV need to alter it,
it would perform a copy of it, decrease the COWREFCNT counter.

One SV can then drop the COW flag when it's the only one holding a pointer
to the PV.

The COWREFCNT is stored at the end of the PV, after the the "\0".

That value is limited to 255, when we reach 255, a new PV would be created,

=head1 FUNCTIONS

=head2 can_cow()

Return a boolean value. True if your Perl version support Copy On Write for SvPVs

=head2 is_cow( PV )

Return a boolean value. True if the SV is cowed SvPV. (check the SV FLAGS)

=head2 cowrefcnt( PV )

Return one integer representing the COW RefCount value.
If the string is not COW, then it will return undef.

=head2 cowrefcnt_max()

Will return the SV_COW_REFCNT_MAX of your Perl. (if COW is supported, this should
be 255 unless customized).