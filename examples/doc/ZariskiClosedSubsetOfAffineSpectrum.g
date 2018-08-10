#! @System ZariskiClosedSubsetOfAffineSpectrum

LoadPackage( "ZariskiFrames" );

#! @Example
ZZ := HomalgRingOfIntegers( );
#! Z
ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( ZZ );
#! The coframe of Zariski closed subsets of the affine spectrum of Z
A := ZariskiReducedClosedSubsetOfAffineSpectrum( HomalgMatrix([2],1,1,ZZ) );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
B := ZariskiClosedSubsetOfAffineSpectrum( HomalgMatrix([12,20],2,1,ZZ));
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
C := ZariskiReducedClosedSubsetOfAffineSpectrum( HomalgMatrix([3],1,1,ZZ) );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
D := ZariskiClosedSubsetOfAffineSpectrum( HomalgMatrix([12],1,1,ZZ) );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
A = B;
#! true
A = C;
#! false
embAB := MorphismOfZariskiClosedSubsets( A, B );
#! <An epi-, monomorphism in The coframe of Zariski closed subsets of the\
#!  affine spectrum of Z>
IsWellDefined( embAB );
#! true
IsIsomorphism( embAB );
#! true
embAC := MorphismOfZariskiClosedSubsets( A, C );
#! <An epi-, monomorphism in The coframe of Zariski closed subsets of the\
#!  affine spectrum of Z>
IsWellDefined( embAC );
#! false
embAD := MorphismOfZariskiClosedSubsets( A, D );
#! <An epi-, monomorphism in The coframe of Zariski closed subsets of the\
#!  affine spectrum of Z>
IsWellDefined( embAD );
#! true
IsIsomorphism( embAD );
#! false
embDA := MorphismOfZariskiClosedSubsets( D, A );
#! <An epi-, monomorphism in The coframe of Zariski closed subsets of the\
#!  affine spectrum of Z>
IsWellDefined( embDA );
#! false
T := TerminalObject( ZC );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
Display( T );
#! (an empty 0 x 1 matrix)
#! 
#! A morphism in Rows( Z )
I := InitialObject( ZC );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
Display( I );
#! [ [  1 ] ]
#! 
#! A morphism in Rows( Z )
AvC := Coproduct( A, C );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
Display( AvC );
#! [ [  -6 ] ]
#! 
#! A morphism in Rows( Z )
AC := DirectProduct( A, C );
#! <An object in The coframe of Zariski closed subsets of the affine spectrum of Z>
Display( AC );
#! [ [  2 ],
#!   [  3 ] ]
#! A morphism in Rows( Z )
DirectProduct( A, C ) = I;
#! true
#! @EndExample
