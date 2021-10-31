## Multivariant Analysis of Crash Severity and Number of Injuries in the State of Iowa
### Using R Programming Language

## Abstract
In this paper, I used multilinear regression to examine the relationship/correlation between the number of injuries and explanatory variables such as driver's age, weather conditions, alcohol test results, manner of crashes, number of vehicles involved in the crash, number of occupants, and day of the week. Also, I used the same explanatory variables to predict crash severity using a multinomial logistic regression model. The result shows that there is a correlation between the explanatory variables and the number of injuries. Also, the multinomial logistic regression model was 7.5% better when compared to a null model. 

## Introduction
Vehicle crash is one of the major causes of death in the nation. In 2019, an estimated 38,800 people lost their lives to car crashes – a 2% decline from 2018 (39,404 deaths) and a 4% decline from 2017 (40,231 deaths). Also, over 4.4 million people were injured seriously enough to require medical attention in crashes in 2019 – also a 2% decreased over 2018 figures. The first nine months of 2020 estimates show that 28,190 people died in motor vehicle traffic crashes. This trend represents an increase of about 4.6 percent compared to 26,941 fatalities reported in the first nine months of 2019. 
In the State of Iowa, a total of 47,715 vehicle crashes occurred in 2020 (10,839 lower than in 2019), resulting in 335 death, 1,301 serious injuries, 5,623 minor injuries, and 8,276 possible injuries. Fatalities from vehicle crashes in Iowa declined from 336 in 2019 to 335 in 2020, although vehicle miles travel was lower in 2020 due to the pandemic. 
The above trends show that even though huge strides have been made regarding safety, road safety engineering, and car safety technologies, vehicle crashes are still a significant issue in our society. This project aims to understand the association between crash severity and variables such as driver's age, weather, alcohol test results, manner of crashes, number of vehicles involved in the crash, number of occupants, and time of day in the State of Iowa. The research question is, what variables determine or influence crash severity and number of injuries?
The vehicle crash data were obtained from the Iowa Department of Transportation (IDOT). The data spanned from 2015 to 2020. The data is collected by various law enforcement agencies in the state and maintained by IDOT. This data set was used as it provided all the relevant information necessary to answer the research question. 
This paper is organized into six sections; the first section introduces the topic, which is under investigation. The second section presents a literature review on crash severity and how other researchers have analyzed it. The third section talks about the techniques used to analyze the research data to answer the research question. The last section talks about the result from the analysis.

## Related Works

A lot of researchers have investigated the factors that cause vehicle crashes. For instance, Rezapour & Ksaibati (2018) investigated the factors contributing to severe truck crashes in conjunction with violation data. The authors used ordinal logistic regression to identify the factors that increased the odds of severe single-truck and multiple-vehicle crashes. The result shows that factors such as non-normal conditions at the time of the crash, driving on the dry-road condition, and having a distraction in the cabin increased the odds of severe single-truck crashes. 
Also, Qin et al. (2010) identified crash-prone locations using quantile regression analysis. The authors created a regression model at the quantile level instead of changes at the mean level. The authors used this method because of the heterogeneity of crash data. They found that quantile regression produced a refined subset of risk-prone locations when compared with other methods. 
In addition to this, Jonathan et al. (2016) created a multivariate spatial crash frequency model for identifying sites with a promise based on crash types. The authors designed this model to improve the precision of crash frequency models used to identify areas with promise. They found that models that consider both multivariate and spatial correlation has the best fit. 
Abdel-Aty et al. also analyze factors that contribute to crashes at intersections. They used tree-based regression methodology to examine the association between particular variables and crash frequency. They used the tree-based regression methodology to cope with multicollinearity between variables, missing observations, and the fact that the actual model form was unknown. They found variations regarding the factors that influence the various types of collision at the intersection. 


You can use the [editor on GitHub](https://github.com/Gabriel-Appiah/Multivariant_Analysis/edit/main/docs/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/Gabriel-Appiah/Multivariant_Analysis/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.
