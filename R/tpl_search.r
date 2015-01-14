#' A light wrapper around the taxonstand fxn to call Theplantlist.org database.
#'
#' THIS FUNCTION IS DEFUNCT.
#'
#' This function was a very light wrapper around TPLck anyway - we don't see further
#' reason to keep this function. Use the Taxonstand functions \code{\link[Taxonstand]{TPL}}
#' and \code{\link[Taxonstand]{TPLck}}, directly. However, we are keeping two functions
#' that give you access to download Theplantlist.org data \code{\link[taxize]{tpl_get}}
#' and to get Theplantlist.org families \code{\link[taxize]{tpl_families}}.
#'
#' @name tpl_search
#' @import Taxonstand plyr
#' @param genus Genus name, only in tpl_search_sql
#' @param taxon A taxonomic name, or a vector of names.
#' @param paral Paralellize or not (logical). Which back-end package you use
#' 		depends on your operating system and just general taste. Possibilities
#' 		include: snow, multicore, parallel, doMC, etc.
#' @param ... Further arguments passed on to the TPL or TPLck function of Taxonstand.
#' 		See \code{TPL} and \code{TPLck} for arguments.
#' @seealso \code{\link[taxize]{tpl_get}}, \code{\link[taxize]{tpl_families}}
#' @examples \dontrun{
#' # Regular non-parallel
#' splist <- c("Heliathus annuus","Abies procera","Poa annua",
#'    "Platanus occidentalis","Carex abrupta","Arctostaphylos canescens",
#'    "Ocimum basilicum","Vicia faba","Quercus kelloggii","Lactuca serriola")
#' tpl_search(taxon = splist)
#'
#' # Use more arguments within TPLck
#' tpl_search(taxon = "Microbryum curvicollum", corr = TRUE)
#' tpl_search(taxon = "Microbryum curvicollum", corr = TRUE, max.distance=5)
#' }

#' @export
#' @rdname tpl_search
tpl_search <- function(taxon, paral = FALSE, ...)
{
  .Defunct(msg="This function is defunct. Use the Taxonstand functions TPL or TPLck directly.")

  if(paral){
    out <- llply(taxon, function(x) TPLck(x, ...), .parallel=TRUE)
    ldply(out)
  } else
  {
    out <- llply(taxon, function(x) try(TPLck(x, ...), silent=TRUE))
    if(any(sapply(out, class)=="try-error"))
      message(geterrmessage())
    out <- out[!sapply(out, class)=="try-error"]
    df <- taxize_ldfast(out)
    df
  }
}

#' theplantlist search
#'
#' @export
#' @rdname tpl_search
#' @examples \dontrun{
#' tpl_search_sql(genus = "Acanthus")
#' }
tpl_search_sql <- function(genus){
  query <- sprintf("SELECT * from plantlist where genus like '%s'", genus)
  plantlist_SQL(query)
}
