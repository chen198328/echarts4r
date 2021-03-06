% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loading.R
\name{e_show_loading}
\alias{e_show_loading}
\alias{e_hide_loading}
\title{Loading}
\usage{
e_show_loading(e, hide.overlay = TRUE, text = "loading",
  color = "#c23531", text.color = "#000",
  mask.color = "rgba(255, 255, 255, 0.8)", zlevel = 0)

e_hide_loading(e)
}
\arguments{
\item{e}{An \code{echarts4r} object as returned by \code{\link{e_charts}}.}

\item{hide.overlay}{Hides the white overaly that appears in shiny when a plot is recalculating.}

\item{text}{Text to display.}

\item{color}{Color of spinner.}

\item{text.color}{Color of text.}

\item{mask.color}{Color of mask.}

\item{zlevel}{Z level.}
}
\description{
Show or hide loading.
}
\details{
This only applies to Shiny.
}
\examples{
\dontrun{

# no redraw
# no loading
library(shiny)
ui <- fluidPage(
  fluidRow(
    column(12, actionButton("update", "Update"))
  ),
  fluidRow(
    column(12, echarts4rOutput("plot"))
  )
)

server <- function(input, output){
  data <- eventReactive(input$update, {
    data.frame(
      x = 1:10,
      y = rnorm(10)
    )
  })
  
  output$plot <- renderEcharts4r({
    data() \%>\% 
      e_charts(x) \%>\% 
      e_bar(y)
  })
}

shinyApp(ui, server)

# add loading
server <- function(input, output){
  data <- eventReactive(input$update, {
    Sys.sleep(1) # sleep one second to show loading
    data.frame(
      x = 1:10,
      y = rnorm(10)
    )
  })
  
  output$plot <- renderEcharts4r({
    data() \%>\% 
      e_charts(x) \%>\% 
      e_bar(y) \%>\% 
      e_show_loading()
  })
}

shinyApp(ui, server)
}

}
