#!/usr/bin/perl

package Database::Oracle;
use base Database;
use DBI;

##########################
#
# Author: Christoph Mueller
# First Version: 04/2017
# Purpose: centralize database logic
#
##########################

sub new {
    shift->SUPER::new(@_)
}

sub getConnection {
	my( $self ) = @_;

	if($self->{DBConnection} eq undef) {
		my $dbDriver 	= $self->{_settings}{'database.driver'};
		my $dbHost 		= $self->{_settings}{'database.hostname'};
		my $dbPort 		= $self->{_settings}{'database.port'};
		my $dbUser 		= $self->{_settings}{'database.user'};
		my $dbPass 		= $self->{_settings}{'database.pass'};
		my $dbSid 		= $self->{_settings}{'database.sid'};
		my %dbArguments = (
		);

		my $dataSource = 'DBI:'.$dbDriver.':SID='.$dbSid.';host='.$dbHost.';port='.$dbPort;

		$self->{DBConnection} = DBI->connect($dataSource, $dbUser, $dbPass, \%dbArguments) or die "Error connecting to ".$self->{_settings}{'database.hostname'}.": ", $DBI::errstr;

		$self->{DBConnection}->{LongReadLen} = 66000;
		$self->{DBConnection}->{LongTruncOk} = 1;
	}

	return $self->{DBConnection};
}


1;
