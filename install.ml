#use "topfind";;
#require "js-build-tools.oasis2opam_install";;

open Oasis2opam_install;;

generate ~package:"ppx_custom_printf"
  [ oasis_lib "ppx_custom_printf"
  ; oasis_lib "ppx_format_lifter"
  ; file "META" ~section:"lib"
  ; oasis_exe "ppx" ~dest:"../lib/ppx_custom_printf/ppx"
  ]
