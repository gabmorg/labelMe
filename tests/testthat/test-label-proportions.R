context("Label app input type check")
library(labelMe)
#
# test_that("")
# > labPropTest <- getLabelProportions(exampleDF)
# > labPropTest$pie_chart
# > labPropTest$freq_chart
# > labPropTest$proportions
# label_group Freq
# 8   Saggital-Right    2
# 3  Transverse-Left    1
# 4       Bladder-NA    1
# 1     Bladder-Left    0
# 2    Saggital-Left    0
# 5      Saggital-NA    0
# 6    Transverse-NA    0
# 7    Bladder-Right    0
# 9 Transverse-Right    0
# > labPropTest$overrep
# label_group Freq
# 8  Saggital-Right    2
# 3 Transverse-Left    1
# 4      Bladder-NA    1
# > labPropTest$underrep
# label_group Freq
# 5      Saggital-NA    0
# 6    Transverse-NA    0
# 7    Bladder-Right    0
# 9 Transverse-Right    0
# > is.data.frame(labPropTest$underrep)
# [1] TRUE
# > is.data.frame(labPropTest$overrep)
# [1] TRUE
