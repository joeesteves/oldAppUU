## Cosas utiles para otros proyectos

### Git Commands
* git fetch origin
* git co -b origin/branch branch
* git remote prune origin -> borra localmente las ramas borradas en github
__Tags__

* git tag -a v5.0.0 ci-hash
* git push --tags
* git tag -d v5.0.0
* git push origin :v5.0.0

### Tags Ctags
  instalando esta gem coffeetags y luego ejecutando $ coffeetags -R -a -F tags
  la a de append es para que lo sume a los tags que ya hayan sido generados

  para ruby generar los tags

```
$ gem install ripper-tags
$ ripper-tags -R --exclude=vendor

```
  para coffescript generar los tags (a: append, f: file <nombre del file>)
```
$ gem install coffeetags
$ coffeetags -R -a -f tags
  ```

### Decimals in generators
  * 'importe:decimal{10,2}'  --> Entre comillas
