package RT::Client::Object;

use strict;
use warnings;
use Filter::Include;
use Spiffy '-Base';
use XML::Simple ();
use XML::Atom::Entry;

include RT::Client::Base;
our @ISA = 'XML::Atom::Entry';

const _rel_map => {
    'service.post'    => 'update',
};

sub update {
    my $uri = $self->_action('update');
    my $res = $self->client->_request($uri, @_, method => 'POST') or return undef;

    # XXX - parse the update result
    return $res->content;
}

1;
