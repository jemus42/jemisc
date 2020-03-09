# pkg_file <- function(..., mustWork = TRUE) {
#   system.file(..., package = 'blogdown', mustWork = mustWork)
# }

generator <- function() getOption('blogdown.generator', 'hugo')

# # scan YAML metadata of all Rmd/md files
# scan_yaml <- function(dir = 'content') {
#   if (missing(dir)) dir = switch(generator(),
#                                  hugo = 'content', jekyll = '.', hexo = 'source'
#   )
#   files = list.files(dir, "[.][Rr]?(md|markdown)$", recursive = TRUE, full.names = TRUE)
#   if (length(files) == 0) return(list())
#   res = lapply(files, function(f) {
#     yaml = bookdown:::fetch_yaml(f)
#     if (length(yaml) == 0) return()
#     yaml = yaml[-c(1, length(yaml))]
#     if (length(yaml) == 0) return()
#     tryCatch(yaml::yaml.load(paste(yaml, collapse = '\n')), error = function(e) {
#       warning("Cannot parse the YAML metadata in '", f, "'")
#       NULL
#     })
#   })
#   setNames(res, files)
# }

collect_yaml <- function(
  fields = c('categories', 'tags', 'packages', 'shows'), dir, uniq = TRUE, sort = TRUE
) {
  res = list()
  meta = blogdown:::scan_yaml(dir)
  for (i in fields) {
    res[[i]] = unlist(lapply(meta, `[[`, i))
    if (sort) res[[i]] = blogdown:::sort2(res[[i]])
    if (uniq) res[[i]] = unique(res[[i]])
  }
  res
}

new_post_addin <- function() {
  sys.source(system.file('scripts', 'new_post.R', package = 'jemisc', mustWork = TRUE))
}

