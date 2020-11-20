# Midterm Assignment

Explain how to select a better value for k (max 200 words):

The principal components can vary in eigenvalue however in many cases there are a lrge number of 0.x values to be found. These values are not as relevent as the larger components and thus by chosing only the 1.0+ values as the set of principle components, we can maximise efficientcy and accuracy. The number for the example case in the code was 55.

Comment on the quality of the reconstructed images:

Due to shortcomings in the functionality of the code, the images produces are not as accurate as I would have desired in general however a trend can be found that the more principle components used, the more accurate the result. The basic structure of the church can be seen throughout the results set however the shape is mmuch more clear for R100 than R10, however the diminishing returns mention above can be seen as R55 does not show that much of a loss from R100 due to R100 containing the less useful 0.x values.
