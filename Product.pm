#!/usr/bin/perl -w

# Product
#
# Copyright (C) 2021 Dr. Sergey Kolevatov
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

############################################################

package Product;

use strict;
use warnings;

use Carp qw(croak);
use Scalar::Util qw(blessed);

sub new($$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$)
{
    my $class = shift;
    my $self =
    {
        handle          => shift,
        id              => shift,
        title           => shift,
        vendor          => shift,
        category        => shift,
        sub_category    => shift,
        price           => shift,
        date            => shift,
        offer_price     => shift,
        offer_date      => shift,
        weight_grams    => shift,
        image_link      => shift,
        product_link    => shift,
        status          => shift,
    };

    bless $self, $class;
    return $self;
}

sub create_from_array($)
{
    my ( $class, $args_ref ) = @_;

    #die "class method invoked on object" if ref $class;

    croak( "new_from_string must be called on a class-name" ) if blessed $class;

    my @args = @{ $args_ref };

    die "wrong number of arguments (" . ( scalar @args ) .", expected 36)" if ( scalar @args != 14 );

    return $class->new(
        $args[0],
        $args[1],
        $args[2],
        $args[3],
        $args[4],
        $args[5],
        $args[6],
        $args[7],
        $args[8],
        $args[9],
        $args[10],
        $args[11],
        $args[12],
        $args[13] );
}

sub quotify($)
{
    my $res = shift;

    $res =~ s/"/""/g;  #"

    $res = '"' . $res . '"';

    return $res;
}

sub to_csv()
{
    my ( $self ) = @_;

    my $res =
        $self->{handle} . "," .
        $self->{id} . "," .
        quotify( $self->{title} ) . "," .
        $self->{vendor} . "," .
        $self->{category} . "," .
        $self->{sub_category} . "," .
        $self->{price} . "," .
        $self->{date} . "," .
        $self->{offer_price} . "," .
        $self->{offer_date} . "," .
        $self->{weight_grams} . "," .
        $self->{image_link} . "," .
        $self->{product_link} . "," .
        $self->{status};

    return $res;
}

sub get_csv_header()
{
    my ( $class ) = @_;

    die "class method invoked on object" if ref $class;

    return "Handle,Id,Title,Vendor,Category,Subcategory,Price,Date,Offer Price,Offer Date,Weight Grams,Image Link,Product Link,Status";
}

sub merge($)
{
    my ( $self, $obj_ref ) = @_;

    die "mismatching handle" if ( $self->{handle} ne $obj_ref->{handle} );

    if( $self->{date} > $obj_ref->{date} )
    {
        return 0;
    }

    my $is_modified = 0;

    if( $self->{id} != $obj_ref->{id} )
    {
        $self->{id} = $obj_ref->{id};
        $is_modified = 1;
    }
    if( $self->{title} ne $obj_ref->{title} )
    {
        $self->{title} = $obj_ref->{title};
        $is_modified = 1;
    }
    if( $self->{body_html} ne $obj_ref->{body_html} )
    {
        $self->{body_html} = $obj_ref->{body_html};
        $is_modified = 1;
    }
    if( $self->{vendor} ne $obj_ref->{vendor} )
    {
        $self->{vendor} = $obj_ref->{vendor};
        $is_modified = 1;
    }
    if( $self->{category} ne $obj_ref->{category} )
    {
        $self->{category} = $obj_ref->{category};
        $is_modified = 1;
    }
    if( $self->{subcategory} ne $obj_ref->{subcategory} )
    {
        $self->{subcategory} = $obj_ref->{subcategory};
        $is_modified = 1;
    }
    if( $self->{price} != $obj_ref->{price} )
    {
        $self->{price} = $obj_ref->{price};
        $is_modified = 1;
    }
    if( $self->{date} != $obj_ref->{date} )
    {
        $self->{date} = $obj_ref->{date};
        $is_modified = 1;
    }
    if( $self->{offer_price} != $obj_ref->{offer_price} )
    {
        $self->{offer_price} = $obj_ref->{offer_price};
        $is_modified = 1;
    }
    if( $self->{offer_date} != $obj_ref->{offer_date} )
    {
        $self->{offer_date} = $obj_ref->{offer_date};
        $is_modified = 1;
    }
    if( $self->{weight_grams} != $obj_ref->{weight_grams} )
    {
        $self->{weight_grams} = $obj_ref->{weight_grams};
        $is_modified = 1;
    }
    if( $self->{image_link} ne $obj_ref->{image_link} )
    {
        $self->{image_link} = $obj_ref->{image_link};
        $is_modified = 1;
    }
    if( $self->{product_link} ne $obj_ref->{product_link} )
    {
        $self->{product_link} = $obj_ref->{product_link};
        $is_modified = 1;
    }
    if( $self->{status} ne $obj_ref->{status} )
    {
        $self->{status} = $obj_ref->{status};
        $is_modified = 1;
    }

    return $is_modified;
}

sub set_status_active()
{
    my ( $self ) = @_;

    $self->{status} = 'active';
}

sub set_status_archived()
{
    my ( $self ) = @_;

    $self->{status} = 'archived';
}

############################################################

1;
