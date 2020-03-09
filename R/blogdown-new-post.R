#' Create a new blogdown post (with tweaks)
#'
#' This is a modified version of `blogdown::new_post` for extra taxonomies.
#' @param title The title of the post.
#' @param author The author of the post.
#' @param categories A character vector of category names.
#' @param tags A character vector of tag names.
#' @param packages,shows A character vector of package names or show names.
#' @param date The date of the post.
#' @param file The filename of the post. By default, the filename will be
#'   automatically generated from the title by replacing non-alphanumeric
#'   characters with dashes, e.g. \code{title = 'Hello World'} may create a file
#'   \file{content/post/2016-12-28-hello-world.md}. The date of the form
#'   \code{YYYY-mm-dd} will be prepended if the filename does not start with a
#'   date.
#' @param slug The slug of the post. By default (\code{NULL}), the slug is
#'   generated from the filename by removing the date and filename extension,
#'   e.g., if \code{file = 'post/2015-07-23-hi-there.md'}, \code{slug} will be
#'   \code{hi-there}. Set \code{slug = ''} if you do not want it.
#' @param title_case A function to convert the title to title case. If
#'   \code{TRUE}, the function is \code{tools::\link[tools]{toTitleCase}()}).
#'   This argument is not limited to title case conversion. You can provide an
#'   arbitrary R function to convert the title.
#' @param subdir If specified (not \code{NULL}), the post will be generated
#'   under a subdirectory under \file{content/}. It can be a nested subdirectory
#'   like \file{post/joe/}.
#' @param ext The filename extension (e.g., \file{.md}, \file{.Rmd}, or
#'   \file{.Rmarkdown}). Ignored if \code{file} has been specified.
#' @export
new_post = function(
  title, kind = '', open = interactive(), author = getOption('blogdown.author'),
  categories = NULL, tags = NULL, packages = NULL, shows = NULL,
  date = Sys.Date(), file = NULL, slug = NULL,
  title_case = getOption('blogdown.title_case'),
  subdir = getOption('blogdown.subdir', 'post'), ext = getOption('blogdown.ext', '.md')
) {
  if (is.null(file)) file = blogdown:::post_filename(title, subdir, ext, date)
  file = blogdown:::trim_ws(file)  # trim (accidental) white spaces
  if (missing(kind)) kind = blogdown:::default_kind(file)
  if (is.null(slug) && blogdown:::auto_slug()) slug = blogdown:::post_slug(file)
  slug = blogdown:::trim_ws(slug)
  if (generator() == 'hugo') file = blogdown:::new_content(file, kind, FALSE) else {
    writeLines(c('---', '', '---'), file)
  }
  if (isTRUE(title_case)) title_case = tools::toTitleCase
  if (is.function(title_case)) title = blogdown:::title_case(title)
  if (getOption('blogdown.warn.future', TRUE)) {
    if (tryCatch(date > Sys.Date(), error = function(e) FALSE)) warning(
      'The date of the post is in the future: ', date, '. See ',
      'https://github.com/rstudio/blogdown/issues/377 for consequences. ',
      'To turn off this warning, set options(blogdown.warn.future = FALSE).'
    )
  }

  do.call(blogdown:::modify_yaml, c(list(
    file, title = title, author = author, date = format(date), slug = slug,
    categories = as.list(categories), tags = as.list(tags),
    shows = as.list(shows), packages = as.list(shows)
  ), if (!file.exists('archetypes/default.md')) list(draft = NULL)
  ))
  if (open) blogdown:::open_file(file)
  file
}

generator <- function() getOption('blogdown.generator', 'hugo')

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

