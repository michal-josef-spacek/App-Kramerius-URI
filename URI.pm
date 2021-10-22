package App::Kramerius::URI;

use strict;
use warnings;

use Getopt::Std;
use Text::DSV;

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Object.
	return $self;
}

# Run.
sub run {
	my $self = shift;

	# Process arguments.
	$self->{'_opts'} = {
		'h' => 0,
	};
	if (! getopts('h', $self->{'_opts'}) || @ARGV < 1
		|| $self->{'_opts'}->{'h'}) {

		print STDERR "Usage: $0 [-h] [--version] kramerius_id\n";
		print STDERR "\t-h\t\tHelp.\n";
		print STDERR "\t--version\tPrint version.\n";
		print STDERR "\tkramerius_id\tKramerius system id. e.g. ".
			"mzk\n";
		return 1;
	}
	$self->{'_kramerius_id'} = shift @ARGV;

	# Read data.
	my $kramerius_data;
	while (my $data = <DATA>) {
		$kramerius_data .= $data;
	}
	my @kramerius = Text::DSV->new->parse($kramerius_data);

	# Get URL.
	my ($library_url, $kramerius_version);
	my $num = 0;
	foreach my $library_ar (@kramerius) {
		$num++;
		if ($num > 0) {
			if ($self->{'_kramerius_id'} eq $library_ar->[1]) {
				$library_url = $library_ar->[3];
				$kramerius_version = $library_ar->[0];
				last;
			}
		}
	}

	# Print URL.
	if (defined $library_url && $kramerius_version) {
		print $library_url.' '.$kramerius_version."\n";
	}

	return 0;
}

1;

=pod

=encoding utf8

=head1 NAME

App::Kramerius::URI - Base class for kramerius-uri script.

=head1 SYNOPSIS

 use App::Kramerius::URI;

 my $app = App::Kramerius::URI->new;
 my $exit_code = $app->run;

=head1 METHODS

=head2 C<new>

 my $app = App::Kramerius::URI->new;

Constructor.

Returns instance of object.

=head2 C<run>

 my $exit_code = $app->run;

Run.

Returns 1 for error, 0 for success.

=head1 EXAMPLE

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
 # http://kramerius.mzk.cz/ 4

=head1 DEPENDENCIES

L<Getopt::Std>,
L<Text::DSV>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/App-Kramerius-URI>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2021 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut

__DATA__
version:code:name:url
3:ABA001:Národní knihovna:http\://kramerius.nkp.cz/
3:ABA013:Národní technická knihovna:http\://kramerius.stk.cz/
3:ABC135:Národní filmový archiv v Praze:http\://kramerius.nfa.cz/
3:ABE304:Institut umění – Divadelní ústav:http\://kramerius.divadlo.cz
3:ABG001:Digitální knihovna Městské knihovny v Praze:http\://kramerius.mlp.cz/
3:BOD006:Mendelova univerzita v Brně:http\://kramerius.mendelu.cz
3:CBA001:Jihočeská vědecká knihovna v Českých Budějovicích:http\://kramerius.cbvk.cz
3:OLA001:Digitalní knihovna novin:http\://noviny.vkol.cz/
3:OSA001:Moravskoslezská vědecká knihovna v Ostravě:http\://camea.svkos.cz
3:PNA001:Studijní a vědecká knihovna Plzeňského kraje:http\://kramerius.svkpl.cz/
3:ULG001:Severočeská vědecká knihovna v Ústí nad Labem:http\://kramerius.svkul.cz
3:ZLG001b:Krajská knihovna Františka Bartoše ve Zlíně:http\://dlib.kfbz.cz
4:mzk:Moravská zemská knihovna:http\://kramerius.mzk.cz/
4:ndk:Národní digitální knihovna:http\://ndk.cz/
4:vkol:Vědecká knihovna v Olomouci:http\://kramerius.kr-olomoucky.cz/
4:svkhk:Studijní a vědecká knihovna v Hradci Králové:http\://kramerius4.svkhk.cz/
4:svkul:Severočeská vědecká knihovna v Ústí nad Labem:http\://kramerius.svkul.cz/
4:knav:Knihovna Akademie věd ČR:https\://kramerius.lib.cas.cz/
4:mkct:Městská knihovna Česká Třebová:http\://k5.digiknihovna.cz/
4:dsmo:Digitální studovna Ministerstva obrany ČR:https\://kramerius.army.cz/
4:mlp:Městská knihovna v Praze:http\://kramerius4.mlp.cz/
4:kkkv:Krajská knihovna Karlovy Vary:http\://k4.kr-karlovarsky.cz/
4:kvkli:Krajská vědecká knihovna Liberec:http\://kramerius.kvkli.cz/
4:svkpk:Studijní a vědecká knihovna Plzeňského kraje:http\://k4.svkpl.cz/
4:nfa:Národní filmový archiv:http\://library.nfa.cz/
4:zmp:Židovské muzeum v Praze:http\://kramerius4.jewishmuseum.cz/
4:nm:Národní muzeum:http\://kramerius.nm.cz/
4:zcm:Knihovna Západočeského muzea v Plzni:http\://kramerius.zcm.cz/
4:cbvk:Jihočeská vědecká knihovna v Českých Budějovicích:http\://kramerius.cbvk.cz/
4:kfbz:Krajská knihovna Františka Bartoše ve Zlíně:http\://dlib.kfbz.cz/
4:nkp:Národní knihovna:http\://kramerius4.nkp.cz/
4:cuni_fsv:Univerzita Karlova v Praze - Fakulta sociálních věd:http\://kramerius.fsv.cuni.cz/
4:ntk:Národní technická knihovna:http\://kramerius.techlib.cz/
4:svkkl:Středočeská vědecká knihovna v Kladně:http\://kramerius.svkkl.cz/
4:lmda:Lesnický a myslivecký digitální archiv:http\://lmda.silvarium.cz/
4:uzei:Knihovna Antonína Švehly:http\://kramerius.uzei.cz/
4:ukb:Univerzitná knižnica v Bratislave:http\://pc139.ulib.sk/
4:slu:Slezská univerzita v Opavě:http\://kramerius.slu.cz/
4:svkos:Moravskoslezská vědecká knihovna v Ostravě:http\://camea.svkos.cz/
4:vugtk:Výzkumný ústav geodetický, topografický a kartografický:http\://knihovna-test.vugtk.cz/
4:vse:Vysoká škola ekonomická v Praze:http\://kramerius.vse.cz/
4:nlk:Národní lékařská knihovna v Praze:http\://kramerius.medvik.cz/
4:mendelu:Mendelova univerzita v Brně:http\://kramerius4.mendelu.cz/
4:kkvhb:Krajská knihovna Vysočiny v Havlíčkově Brodě:http\://kramerius.kkvysociny.cz/
4:cdk:Česká Digitální knihovna:http\://cdk.lib.cas.cz/
4:nmzv:Národní muzeum - Zvuk:http\://kramerius.nm.cz/
