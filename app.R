library(shiny)
library(reactcharteditor)
library(plotly)
library(htmlwidgets)

ui <- div(
  br(),
  plotlyOutput("myPlot"),
  plotly_editor("editorID")
)

server <- function(input, output, session) {
  output$myPlot <- renderPlotly({
    editBtn <- list(
      name = "Edit",
      icon = list(
        path = "M7.127 22.562l-7.127 1.438 1.438-7.128 5.689 5.69zm1.414-1.414l11.228-11.225-5.69-5.692-11.227 11.227 5.689 5.69zm9.768-21.148l-2.816 2.817 5.691 5.691 2.816-2.819-5.691-5.689z",
        transform = 'scale(0.7)'
      ),
      click = htmlwidgets::JS("
        function(gd) {
          Shiny.setInputValue('editButtonClicked', gd.id);
        }
      ")
    )
    
    plot_ly(x = c(1, 2, 3, 4, 5), y = c(1, 2, 4, 8, 16), type = 'scatter') %>%
      layout(title = 'My Plotly Chart') %>%
      config(modeBarButtonsToAdd = list(editBtn))
  })
  
  observe({
    update_plotly_editor(session, "editorID", configuration = list(plotId = input$editButtonClicked), value = list())
  })
}

shinyApp(ui, server)