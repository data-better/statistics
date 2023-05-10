if (!require("remotes")) {
  install.packages("remotes")
}
library(remotes)
#voice input package heyshiny
install_github("jcrodriguez1989/heyshiny", dependencies = TRUE)
install_github("gexijin/RTutor")
install.packages("canvasXpress")
# After the app is started, you can click on Settings and paste the API key.
# You can also save this key as a text file called api_key.txt in the working directory.

library(RTutor)
run_app()

# Use the mpg data frame. Use ggplot2 to create a boxplot of hwy vs. class. Color by class.
# Use the mpg data frame. Create a correlation map of all the columns that contain numbers.