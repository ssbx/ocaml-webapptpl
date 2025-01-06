(lang dune 3.17)

(name webapptpl)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Sébastien Serre <ssbx@github.com>")
(maintainers "Sébastien Serre <ssbx@github.com>")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name webapptpl)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dream cmdliner toml atdgen)
 (tags
  ("add topics" "to describe" your project)))
