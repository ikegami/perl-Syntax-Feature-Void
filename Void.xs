#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
#include "wrap_keyword_plugin.inc.c"


STATIC SV *hint_key_sv;


#define is_syntax_enabled() SvTRUE( cop_hints_fetch_sv( PL_curcop, hint_key_sv, 0, 0 ) )


STATIC OP *parse_void( pTHX ) {
#define parse_void() parse_void( aTHX )
   return op_contextualize( parse_termexpr( 0 ), G_VOID );
}


STATIC Perl_keyword_plugin_t next_keyword_plugin = NULL;
#define next_keyword_plugin( a, b, c ) next_keyword_plugin( aTHX_ a, b, c )


STATIC int my_keyword_plugin( pTHX_ char *keyword_ptr, STRLEN keyword_len, OP **op_ptr ) {
   if ( is_syntax_enabled() ) {
      if ( memEQs( keyword_ptr, keyword_len, "void" ) ) {
         *op_ptr = parse_void();
         return KEYWORD_PLUGIN_EXPR;
      }
   }

   return next_keyword_plugin( keyword_ptr, keyword_len, op_ptr );
}


STATIC void boot( pTHX ) {
#define boot() boot( aTHX )
   wrap_keyword_plugin( my_keyword_plugin, &next_keyword_plugin );

   hint_key_sv = newSVpvs( "Syntax::Feature::Void::void" );
   SvREADONLY_on( hint_key_sv );
}


/* ======================================== */

MODULE = Syntax::Feature::Void   PACKAGE = Syntax::Feature::Void


void
hint_key()
   PPCODE:
      SvREFCNT_inc( hint_key_sv );
      XPUSHs( hint_key_sv );
      XSRETURN( 1 );


BOOT:
   boot();
