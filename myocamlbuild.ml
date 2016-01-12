(* OASIS_START *)
(* OASIS_STOP *)
# 3 "myocamlbuild.ml"

(* Temporary hacks *)
let js_hacks = function
  | After_rules ->
    rule "Generate a cmxs from a cmxa"
      ~dep:"%.cmxa"
      ~prod:"%.cmxs"
      ~insert:`top
      (fun env _ ->
         Cmd (S [ !Options.ocamlopt
                ; A "-shared"
                ; A "-linkall"
                ; A "-I"; A (Pathname.dirname (env "%"))
                ; A (env "%.cmxa")
                ; A "-o"
                ; A (env "%.cmxs")
            ]));

    (* Pass -predicates to ocamldep *)
    pflag ["ocaml"; "ocamldep"] "predicate" (fun s -> S [A "-predicates"; A s])
  | _ -> ()

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
    js_hacks hook;
    dispatch hook;
    dispatch_default hook)

