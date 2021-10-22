#!/usr/bin/env perl

use strict;
use warnings;

use App::Kramerius::URI;

# Arguments.
@ARGV = (
        'mzk',
);

# Run.
exit App::Kramerius::URI->new->run;

# Output like:
# TODO