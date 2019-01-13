# Text analysis using tidytext and dplyr in R using Jeopardy Data

# install folowing packages and load the libraries
#     tidytext
#     dplyr
#     ggplot2

# Read the Jeopardy data, making sure to uncheck StringsAsFactors
# This dataset contains the answer description which we will mine

# store the data in a shorter named dataframe
J_Data <- JEOPARDY_Data

# count number of rows
ncount <- nrow(J_Data)
ncount

# extract only the Answer column into a dataset
AnswerData <- J_Data$Answer

# convert the data to a data frame
text_df <- data_frame(line = 1:ncount, text = AnswerData)
head(text_df)

# tokenize with standard tokenization using unnest_tokens from tidytext
token_data <- unnest_tokens(text_df, word, text)

# remove stop-words using anti_join function from dplyr
# stop_words come from tidytext package
token_data <- anti_join(token_data, stop_words)

# use the count() function of dplyr to view most common words
wordcount <- count(token_data,word, sort = TRUE)

# filter the words to include only those that occur more than 500 times 
# using filter function from dplyr
# Using 500 times for this chart, while we used 5000 times for chart 1 is because
# the max frequency in answer column is  2056(from above wordcount output) 
# and using 5000 times will not return anything
wordcountfiltered <- filter(wordcount, n > 500)

# visualize with ggplot
ggplot(wordcountfiltered, aes(reorder(word, n), n)) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  coord_flip()