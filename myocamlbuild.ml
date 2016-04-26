(* OASIS_START *)
(* OASIS_STOP *)
# 3 "myocamlbuild.ml"

module JS = Jane_street_ocamlbuild_goodies

let dev_mode = true

let dispatch = function
  | After_rules ->
    rule "format lifter"
      ~prod:"format-lifter/ppx_format_lifter.ml"
      (fun _ _ ->
        Cmd (S [ P "ocamlfind"
               ; A "ppx_tools/genlifter"
               ; A "Pervasives.format6"
               ; Sh ">"
               ; A "format-lifter/ppx_format_lifter.ml"
               ]))
  | _ ->
    ()

let () =
  Ocamlbuild_plugin.dispatch (fun hook ->
    JS.alt_cmxs_of_cmxa_rule hook;
    JS.pass_predicates_to_ocamldep hook;
    if dev_mode && not Sys.win32 then JS.track_external_deps hook;
    dispatch hook;
    dispatch_default hook)

