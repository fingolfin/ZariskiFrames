#
# ZariskiFrames: The coframe of Zariski closed subsets in an affine variety
#
# Implementations
#

##
InstallMethod( ClosedSubsetOfSpec,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, A, ZC;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    ObjectifyObjectForCAPWithAttributes( A, ZC,
            PreMorphismOfUnderlyingCategory, I,
            UnderlyingRing, R,
            IsClosedSubobject, true
            );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return ClosedSubsetOfSpec( AsCategoryOfRowsMorphism( mat ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a homalg ring element",
        [ IsHomalgRingElement ],

  function( r )
    
    return ClosedSubsetOfSpec( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, A, ZC;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    ObjectifyObjectForCAPWithAttributes( A, ZC,
            ReducedMorphismOfUnderlyingCategory, I,
            UnderlyingRing, R,
            IsClosedSubobject, true
            );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return ClosedSubsetOfSpecByReducedMorphism( AsCategoryOfRowsMorphism( mat ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a homalg ring element",
        [ IsHomalgRingElement ],

  function( r )
    
    return ClosedSubsetOfSpecByReducedMorphism( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, A, ZC;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    ObjectifyObjectForCAPWithAttributes( A, ZC,
            StandardMorphismOfUnderlyingCategory, I,
            UnderlyingRing, R,
            IsClosedSubobject, true
            );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return ClosedSubsetOfSpecByStandardMorphism( AsCategoryOfRowsMorphism( mat ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a homalg ring element",
        [ IsHomalgRingElement ],

  function( r )
    
    return ClosedSubsetOfSpecByStandardMorphism( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpec,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return ClosedSubsetOfSpec( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return ClosedSubsetOfSpecByReducedMorphism( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return ClosedSubsetOfSpecByStandardMorphism( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local name, ZariskiCoframe;
    
    name := "The coframe of Zariski closed subsets of the affine spectrum of ";
    
    name := Concatenation( name, RingName( R ) );
    
    ZariskiCoframe := CreateCapCategory( name );
    
    SetUnderlyingRing( ZariskiCoframe, R );
    
    ZariskiCoframe!.UnderlyingCategory := CategoryOfRows( R );
    
    ZariskiCoframe!.Constructor := ClosedSubsetOfSpec;
    ZariskiCoframe!.ConstructorByReducedMorphism := ClosedSubsetOfSpecByReducedMorphism;
    ZariskiCoframe!.ConstructorByStandardMorphism := ClosedSubsetOfSpecByStandardMorphism;
    
    AddObjectRepresentation( ZariskiCoframe, IsObjectInZariskiCoframeOfAnAffineVariety );
    
    AddMorphismRepresentation( ZariskiCoframe, IsMorphismInZariskiCoframeOfAnAffineVariety );
    
    ADD_COMMON_METHODS_FOR_COHEYTING_ALGEBRAS( ZariskiCoframe );
    
    ADD_COMMON_METHODS_FOR_FRAMES_AND_COFRAMES_DEFINED_USING_CategoryOfRows( ZariskiCoframe );
    
    ##
    AddIsHomSetInhabited( ZariskiCoframe,
      IsHomSetInhabitedForCoframesUsingCategoryOfRows );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZariskiCoframe,
          IsEqualForObjectsIfIsHomSetInhabitedForCoframesUsingCategoryOfRows );
        
    fi;
    
    ##
    AddTerminalObject( ZariskiCoframe,
      function( arg )
        local T;
        
        T := ClosedSubsetOfSpecByStandardMorphism( HomalgZeroMatrix( 0, 1, R ) );
        
        SetIsTerminal( T, true );
        
        return T;
        
    end );
    
    ##
    AddInitialObject( ZariskiCoframe,
      function( arg )
        local I;
        
        I := ClosedSubsetOfSpecByStandardMorphism( HomalgIdentityMatrix( 1, R ) );
        
        SetIsInitial( I, true );
        
        return I;
        
    end );
    
    ##
    AddCoproduct( ZariskiCoframe,
      function( L )
        local C;
        
        if Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, MorphismOfUnderlyingCategory );
        
        C := INTERSECTION_OF_IDEALS_USING_CategoryOfRows( L );
        
        return ClosedSubsetOfSpecByReducedMorphism( C );
            
    end );
    
    ##
    AddDirectProduct( ZariskiCoframe,
      function( L )
        local P;
        
        L := MaximalObjects( L, IsSubset );
        
        if Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, MorphismOfUnderlyingCategory );
        
        P := UniversalMorphismFromDirectSum( L );
        
        return ClosedSubsetOfSpec( P );
        
    end );
    
    ## the closure of the set theortic difference
    AddCoexponentialOnObjects( ZariskiCoframe,
      function( A, B )
        local L;
        
        B := MorphismOfUnderlyingCategory( B );
        
        if IsZero( B ) then
            return InitialObject( A );
        fi;
        
        A := MorphismOfUnderlyingCategory( A );
        
        A := UnderlyingMatrix( A );
        B := UnderlyingMatrix( B );
        
        L := List( [ 1 .. NrRows( B ) ], r -> SyzygiesGeneratorsOfRows( CertainRows( B, [ r ] ), A ) );
        
        L := List( L, ClosedSubsetOfSpecByReducedMorphism );
        
        return Coproduct( L );
        
    end );
    
    Finalize( ZariskiCoframe );
    
    return ZariskiCoframe;
    
end );

##
InstallMethod( IsOpen,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],

  function( A )
    
    return IsClosed( -A );
    
end );

##
InstallMethod( Dimension,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],

  function( A )
    
    return AffineDimension( UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) ) );
    
end );

##
InstallMethod( DegreeAttr,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],

  function( A )
    
    return AffineDegree( UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) ) );
    
end );

##
InstallMethod( AClosedSingleton,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframe and IsObjectInZariskiFrameOrCoframeOfAnAffineVariety ],
        
  function( A )
    local C;
    
    C := CapCategory( A );
    
    A := UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) );
    
    A := AMaximalIdealContaining( A );
    
    A := C!.ConstructorByReducedMorphism( A );
    
    return A;
    
end );

##
InstallMethod( RingMorphismOfAClosedPoint,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframe and IsObjectInZariskiFrameOrCoframeOfAnAffineVariety ],
        
  function( A )
    local R, singleton, s, indets, matrix, point, zero_rows, new_indets,
          k, S, map, rel, char;
    
    R := UnderlyingRing( A );
    
    singleton := AClosedSingleton( A );
    
    s := UnderlyingMatrix( StandardMorphismOfUnderlyingCategory( singleton ) );
    
    indets := Indeterminates( R );
    
    matrix := HomalgMatrix( indets, Length( indets ), 1, R );
    
    point := DecideZero( matrix, s );
    
    zero_rows := ZeroRows( matrix - point );
    
    new_indets := indets{zero_rows};
    
    k := CoefficientsRing( R );
    
    S := k * List( new_indets, String );
    
    if not zero_rows = [ ] then
        map := RingMap( new_indets, S, R / s );
        rel := GeneratorsOfKernelOfRingMap( map );
        if HasIsIntegersForHomalg( k ) and IsIntegersForHomalg( k ) then
            char := Eliminate( rel );
            if not IsZero( char ) then
                char := EntriesOfHomalgMatrix( char );
                char := List( char, a -> EvalString( String( a ) ) );
                char := Gcd( char );
                if not IsPrime( char ) then
                    Error( "a closed point cannot be defined over a mixed characteristic, here ", char, "\n" );
                fi;
                k := HomalgRingOfIntegersInUnderlyingCAS( char, k );
                S := k * List( new_indets, String );
                rel := S * rel;
                rel := BasisOfRows( rel );
            fi;
        fi;
        S := S / rel;
    fi;
    
    point := S * point;
    
    A := UnderlyingMatrix( StandardMorphismOfUnderlyingCategory( A ) );
    
    map := RingMap( point, R / A, S );
    
    SetIsMorphism( map, true );
    
    map!.singleton := singleton;
    
    return map;
    
end );
