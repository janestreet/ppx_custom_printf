(* OASIS_START *)
(* OASIS_STOP *)
# 3 "myocamlbuild.ml"

let dispatch = function
  | After_rules ->
    rule "workaround buggy tooling"
      ~dep:"%.cmxa"
      ~prod:"%.cmxs"
      ~insert:`top
      (fun env _ ->
         Cmd (S [ !Options.ocamlopt
                ; A "-shared"
                ; A "-linkall"
                ; A (env "%.cmxa")
                ; A "-o"
                ; A (env "%.cmxs")
                ]));
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

let () = Ocamlbuild_plugin.dispatch (fun hook -> dispatch hook; dispatch_default hook)
