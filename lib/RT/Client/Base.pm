# Yes, the lack of a 'package' is deliberate.

use strict;
use warnings;

field 'uri';
field 'doc';
field 'client';

field members => {};
field actions => {};
field prototypes => {};

*XXX = *Spiffy::XXX;

sub status { $self->client->status(@_) }
sub errstr { $self->client->errstr(@_) }

sub new {
    my %args = @_;
    my $rv = $args{Stream} ? $self->SUPER::new(%args) : {};
    bless($rv, $self);

    $rv->uri($args{URI}) or die 'Missing URI';
    $rv->client($args{Client}) or die 'Missing Client';

    return $rv;
}

sub init {
    $self->SUPER::init(@_);
    return if $self->{init}++;

    $self->_init_links;
    $self->_init_entries;
    return $self;
}

sub _init_links {
    foreach my $link ($self->link) {
	my $rel = $link->rel;
	my ($member, $action) = split(/!/, $link->title, 2);
	next if $member =~ /^_/;

	if ($member) {
	    next;
	    XXX("member link not handled");
	}

	$action ||= $self->_rel_map->{$rel} or die "rel not handled: $rel";
	$self->actions->{$action} = $link->href;
    }
}

sub _action {
    $self->actions->{$_[0]} or die "Cannot find '$_[0]' URI for $self";
}

1;
