# Packages
library(shiny)
library(bslib)
library(ggplot2)

# Interface
ui <- page_navbar(
  title = "Título do app", 
  theme = bs_theme(
    # https://rstudio.github.io/bslib/articles/theming/index.html#main-colors
    primary = "#237570",
    secondary = "#E0510A",
    success = "#936728"
  ),

  # Logo
  tags$head(
    tags$script(
      HTML('$(document).ready(function() {
             $(".navbar .container-fluid")
               .append("<img id = \'myImage\' src=\'selo_obs_h.png\' align=\'right\' height = \'57.5px\'>"  );
            });')),
    tags$style(
      HTML('@media (max-width:992px) { #myImage { position: fixed; right: 10%; top: 0.5%; }}')
    )),

  # Translation
  tags$script(
    HTML("
      $(document).ready(function() {
        // Change the text 'Expand' in all tooltips
        $('.card.bslib-card bslib-tooltip > div').each(function() {
          if ($(this).text().includes('Expand')) {
            $(this).text('Expandir');
          }
        });
  
        // Use MutationObserver to change the text 'Close'
        var observer = new MutationObserver(function(mutations) {
          $('.bslib-full-screen-exit').each(function() {
            if ($(this).html().includes('Close')) {
              $(this).html($(this).html().replace('Close', 'Fechar'));
            }
          });
        });
  
        // Observe all elements with the class 'card bslib-card'
        $('.card.bslib-card').each(function() {
          observer.observe(this, { 
            attributes: true, 
            attributeFilter: ['data-full-screen'] 
          });
        });
      });
    ")
  ),

  # Map page
  nav_panel(
    title = "Página A",

    # Sidebar
    layout_sidebar(
      sidebar = sidebar(
        textInput(inputId = "text_test", label = "Texto"),
        dateInput(inputId = "date_test", label = "Data"),
        selectInput(inputId = "select_test", choices = c("A", "B", "C"), label = "Dropdown")
      ),

      # Card
      card(
        full_screen = TRUE,
        card_body(
          plotOutput(outputId = "graph")
        )
      )

    )
  ),

  # Graphs page
  nav_panel(
    title = "Página B",

    layout_sidebar(
      sidebar = sidebar(
        
      ),

      # Graphs card
      card(
        full_screen = TRUE,
        card_header("Card header"),
        card_body()
      )
    )
  ),

  # About page
  nav_panel(
    title = "Página B",
    card(
      card_header("Card title"),
      p("Bla bla bla.")
    ),
    accordion(
      multiple = FALSE,
      accordion_panel(
        "Título A",
        p("Bla bla bla.")
      ),
      accordion_panel(
        "Título B",
        p("Bla bla bla.")
      ),
      accordion_panel(
        "Título C",
        p("Bla bla bla.")
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  output$graph <- renderPlot({
    ggplot(data = iris, aes(x = Sepal.Length, Petal.Length, color = Species)) +
      geom_point()
  })

}

shinyApp(ui, server)