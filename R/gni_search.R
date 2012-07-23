#' Search for taxonomic names using the Global Names Index.
#' 
#' Uses the Global Names Index, see \link{http://gni.globalnames.org/} for information. 
#' 
#' @import stringr RJSONIO RCurl plyr
#' @param search_term Name pattern you want to search for search term may include 
#' 		following options (Note: can, uni, gen, sp, ssp, au, yr work only for parsed names):
#' 			*:	wild card	Search by part of a word	planta*
#' 			exact:	exact match	Search for exact match of a literal string	exact:Parus major
#'			ns:	name string	Search for literal string from its beginning (other modifiers will be ignored)	ns:parus maj*
#'			can:	canonical form	Search name without authors (other modifiers will be ignored)	can:parus major
#'			uni:	uninomial	Search for higher taxa	uni:parus
#'			gen:	genus	Search by genus epithet of species name	gen:parus
#'			sp:	species	Search by species epithet	sp:major
#'			ssp:	subspecies	Search by infraspecies epithet	ssp:major
#'			au:	author	Search by author word	au:Shipunov
#'			yr:	year	Search by year	yr:2005
#' @param per_page Number of items per one page (numbers larger 
#' 		than 1000 will be decreased to 1000) (default is 30).
#' @param page Page number you want to see (default is 1).
#' @param justtotal Return only the total results found.
#' @param url Base url for the API; leave as is.
#' @author Scott Chamberlain {myrmecocystus@@gmail.com}
#' @return Data.frame of results.
#' @seealso \code{\link{gnr}}, \code{\link{gnr_datasources}}, \code{\link{gni_details}}, and \code{\link{gni_parse}}.
#' @keywords globalnamesindex names taxonomy
#' @examples \dontrun{
#' gni_search(search_term = "ani*")
#' gni_search(search_term = "ama*", per_page = 3, page = 21)
#' gni_search(search_term = "animalia", per_page = 8, page = 1)
#' gni_search(search_term = "animalia", per_page = 8, page = 1, justtotal=T)
#' }
#' @export
gni_search <- function(search_term = NULL, per_page = NULL, page = NULL, justtotal = FALSE, 
	url = "http://gni.globalnames.org/name_strings.json") 
{
	query <- compact(list(search_term = search_term, per_page = per_page, page = page))
	out <- parsed_content( GET(url, query = query) )
	if(justtotal == TRUE){out$name_strings_total} else
		{
			checknull <- function(x) {if(is.null(x)){"none"} else{x}}
			df <- ldply(out$name_strings, function(x) 
				t(data.frame(c( checknull(x[["name"]]), checknull(x[["id"]]), 
												checknull(x[["lsid"]]), checknull(x[["uuid_hex"]]), 
												checknull(x[["resource_url"]]) ))))
			names(df) <- c("name","id","lsid","uuid_hex","resource_url")
			df
		}
}