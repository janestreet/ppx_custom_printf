let package_name = "ppx_custom_printf"

let sections =
  [ ("lib",
    [ ("built_lib_ppx_custom_printf", None)
    ; ("built_lib_ppx_format_lifter", None)
    ],
    [ ("META", None)
    ])
  ; ("libexec",
    [ ("built_exec_ppx", Some "ppx")
    ],
    [])
  ]
