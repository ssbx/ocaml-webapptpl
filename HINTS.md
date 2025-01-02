
## Libs obligatoires

Obligatoire:
- atdgen
- yojson
- toml
- logs (voir ppx_here,ppx_fail)
- cmdliner
- lwt

A évaluer d'urgence:
- gen_js_api
- graphql
- jsonschema2atd (json schema to data.mli)
- tyxml
- cow (helpers pour fichiers web: xml,css,http...)
- orm


## tests/branches/templates

### serveurs/outils/exemples

- mirage-seal
- mirage-www

### front-end

- dream
- eliom ("sinatra like")
- opium
- sihl

### back-end

- bonsai (toolkit complet/complexe)
- ocsigen-toolkit (toolkit complet/complexe)
- brr (toolkit basique/simple)
- fmlib (comme "elm language", pas de websocket?)
- js_of_ocaml (ocaml bytecode vers js)
- melange (ocaml code vers js)
- rescript (compile vers js, libs js)
  - rescript/react (voir site. bon support de react.js)
  - rescript/nextjs (voir site.nextjs est un framework sur react)
  - rescript vitejs (voir site.vitejs est un build tool, pour react ou nextjs)
- reason (compile vers js, libs js et ocaml/opam)
  - reason-react
  - spin (generateur de projets Reason/Ocaml)
- vdom (voir opam eml_playground_web, elm_playground_web)

## libs secu

- jwt
- cookie
- FPauth (pour dream)
- twostep
- spoke

## libs web a evaluer

- crunch (filesystem en mémoire)
- syndic/ocamlrss (rss)
- ocaml-hls (hls.js video player)
- ocaml-js-video-players (inclusion video youtube,dailymotion,vimeo)

## bus

- amqp-client
- kafka
- wamp

## DBs

- caqti
- ezirmin (irmin)

## mails

- sendmail-mirage (sendmail avec lwt)
