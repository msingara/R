# Text analysis using tidytext and dplyr in R using Jeopardy Data

# install folowing packages and load the libraries
#     tidytext
#     dplyr
#     ggplot2

# Read the Jeopardy data, making sure to uncheck StringsAsFactors
# This dataset contains the question description which we will mine

# store the data in a shorter named dataframe
J_Data <- JEOPARDY_Data

# count number of rows
ncount <- nrow(J_Data)
ncount

# extract only the Question column into a dataset
QuestionData <- J_Data$Question

# convert the data to a data frame
text_df <- data_frame(line = 1:ncount, text = QuestionData)
head(text_df)

# tokenize with standard tokenization using unnest_tokens from tidytext
token_data <- unnest_tokens(text_df, word, text)

# remove stop-words using anti_join function from dplyr
# stop_words come from tidytext package
token_data <- anti_join(token_data, stop_words)

# use the count() function of dplyr to view most common words
wordcount <- count(token_data,word, sort = TRUE)

# filter the words to include only those that occur more than 5000 times 
# using filter function from dplyr
wordcountfiltered <- filter(wordcount, n > 5000)

# visualize with ggplot
ggplot(wordcountfiltered, aes(reorder(word, n), n)) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  coord_flip()