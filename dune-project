(lang dune 3.17)

(name webapptpl)

(generate_opam_files true)

(source
  (github ssbx/ocaml-webapptpl))

(authors     "Sébastien Serre <ssbx@github.com>")
(maintainers "Sébastien Serre <ssbx@github.com>")

(license MIT)

(documentation 
  https://github.com/ssbx/ocaml-webapptpl/blob/dream/README.md)

(package
  (name webapptpl)
  (synopsis "Full web application template")
  (description "")
  (depends ocaml dream cmdliner toml atdgen)
  (tags (web template "web application" "application template")))
