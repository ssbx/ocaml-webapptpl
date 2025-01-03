# installer le plugin firefox:

Doit être fait a chaque démarage de firefox

- about:debugging
- click "This Firefox"
- click "Load temporary add-on"
- ouvrir ~/.opam/default/share/brr/console/manifest.json

# problème "3rdpartyStorage"

about:config
privacy.restrict3rdpartystorage.skip_list (chaine) = file://qsldkfj/sdkf


# TODO

- donner au fichier js (qui est gros) un nom random, et une durée de vie
maximale. Changer de nom pour mettre à jour les clients.
