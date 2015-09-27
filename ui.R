shinyUI(
        pageWithSidebar(
                headerPanel("Random brain"),
                sidebarPanel(
                        textInput(inputId="text1", label="Numerical Input 1"),
                        textInput(inputId="text2", label="Numerical Input 2"),
                        textInput(inputId="text3", label="Numerical Input 3"),
                        textInput(inputId="text4", label="Numerical Input 4"),
                        textInput(inputId="text5", label="Numerical Input 5"),
                        textInput(inputId="text6", label="Numerical Input 6"),
                        textInput(inputId="text7", label="Numerical Input 7"),
                        textInput(inputId="text8", label="Numerical Input 8"),
                        textInput(inputId="text9", label="Numerical Input 9"),
                        textInput(inputId="text10", label="Numerical Input 10"),
                        #textInput(inputId="text1",label="Input Text1"),
                        #textInput(inputId="text2",label="Input Text2"),
                        #textInput(inputId="text3",label="Input Text3"),
                        actionButton("goButton","Go!")
                ),
                mainPanel(
                        tabsetPanel(
                        
                                tabPanel("Plot", plotOutput('newHist')),
                                
                                tabPanel("Summary", 
                                         
                                         p('General description of your numeric set'),
                                         textOutput('text1'),
                                         p('Statistics'),
                                         #textOutput('text2'),
                                         dataTableOutput("mytable1")
                                         
                                         ),
                 
                                tabPanel("Documentation", 
                                         h1('Random brain, short documentation'),
                                         h3('Prologue'),
                                         p('The purpose of this little game is to check how much randomness is the users brain capable to produce. The computer randomness is the old and 
                                          famous problem. Interesting question is whether brain is capable to produce truly random or pseudo-random sequence. This is hard question and curiosity
                                          about it was the initial motivation beyond this little application. Of course this little app is NOT an answer. It should be taken as a nice
                                          exercise and maybe fun to test how good in randomness one is.'
                                         ),
                                         h3('Short description of a random brain'),
                                         p('The aim of the game is very simple. The user is asked to fill 10 numerical inputs, that can be seen on the left hand side. The numerals in each input
                                          have to be NATURAL numbers. The application has been made in a way that even if user enters some wrong characters, that are not naturally interpreted as Natural numbers. 
                                        The application checks it and the non numerical input is disregarded. User should pick numbers as random as possible and preferably all of the order of 10^8 in each input line.
                                          '),
                                         p('
                                        After filling all the columns user can submit button GO! That results into the histogram of numerals user entered (tab "Plot") and some statistical summary of the random sequence (tab "Summary"). 
                                        User can check the randomness of the sequence by the chi^2 test and p-values (provided as a particular result in "Summary"). User can also see length, the mean and standard deviation of entered sequence. 
                                          '),
                                         p('
                                       Have a fun and be a bit random too :).
                                          ')
                                )
                                
                                
                        #plotOutput('newHist'),
                        
                        )
                        
                )
        )
)