# Building a Prod-Ready, Robust Shiny Application.
# 
# Each step is optional. 
# 
# 1 - On init
# library(devtools) # devtools: Tools to Make Developing R Packages Easier
devtools::install_github('plotly/dashR') # The core dash backend
# devtools::install_github('plotly/dash-html-components') # HTML components
# devtools::install_github('plotly/dash-core-components') # Supercharged components

# 
## 1.1 - Fill the descripion & set options
## 
## Add information about the package that will contain your app

golem::fill_desc(
  pkg_name = "appwithdash", # The Name of the package containing the App 
  pkg_title = "An app with DashR and golem", # The Title of the package containing the App 
  pkg_description = "Test golem with a Dash application.", # The Description of the package containing the App 
  author_first_name = "Sébastien", # Your First Name
  author_last_name = "Rochette",  # Your Last Name
  author_email = "sebastien@thinkr.fr",      # Your Email
  repo_url = NULL # The (optional) URL of the GitHub Repo
)     

## Use this desc to set {golem} options

# golem::set_golem_options()

## 1.2 - Set common Files 
## 
## If you want to use the MIT licence, README, code of conduct, lifecycle badge, and news

usethis::use_mit_license( name = "ThinkR" )  # You can set another licence here
usethis::use_readme_rmd( open = TRUE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )

usethis::use_news_md( open = FALSE )
usethis::use_git()

# Actions
# Remove all @import shiny
# Modify run_app
# Fill app_ui
# Document
attachment::att_to_description()
golem::document_and_reload()
# appwithdash::run_app()

# Deploy with docker
usethis::use_build_ignore(".*\.tar\.gz$", escape = FALSE)
usethis::use_git_ignore("*.tar.gz")
devtools::build(path = ".")
golem::add_dockerfile()
# Modify dockerfile to include 'remotes::install_github("plotly/dashR")'
# Modify dockerfile to include 'remotes::install_github("ThinkR-open/golem")'
# Build docker
system("docker build -t appwithdash .")
# Run docker
library(future)
plan(multisession)
future({
  system(paste0("docker run --rm --name app -p 8050:8050 appwithdash"), intern = TRUE)
})
browseURL("http://127.0.0.1:8050")
# Stop docker
system("docker kill app")
system("docker rm app")


## 1.3 - Add a data-raw folder
## 
## If you have data in your package
# usethis::use_data_raw( name = "my_dataset", open = FALSE ) # Change "my_dataset"

## 1.4 - Init Tests
## 
## Create a template for tests

# golem::use_recommended_tests()

## 1.5 : Use Recommended Package

# golem::use_recommended_deps()

## 1.6 Add various tools

# If you want to change the favicon (default is golem's one)
# golem::remove_favicon()
# golem::use_favicon() # path = "path/to/ico". Can be an online file. 

# Add helper functions 
# golem::use_utils_ui()
# golem::use_utils_server()

# You're now set! 
# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

