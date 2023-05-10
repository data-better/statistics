install.packages("pak")
pak::pak("MichelNivard/gptstudio")

my_key = "My API Key"
Sys.setenv(OPENAI_API_KEY = my_key)

library(gptstudio)