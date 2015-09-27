library(shiny)
library(UsingR)
library(ggplot2)
library(gridExtra)
library(functional)

shinyServer(
        function(input,output){
                
                completer<-function(x){
                                                f<-data.frame(as.numeric((substring(x, seq(1,nchar(x),1), seq(1,nchar(x),1)))))
                                                h<-as.numeric(f[complete.cases(f),])
                                                if(nrow(f)!=length(h)&length(h)!=0){
                                                        p<-c("Some of the imput was not natural number. Not natural number part was disregarded.")
                                                        n<-c(0)
                                                        return(data.frame(n,p,h))
                                                }
                                                
                                               else if(nrow(f)!=length(h)&length(h)==0){
                                                        p<-c("Wrong imput, no number detected.")
                                                        n<-c(3)
                                                        h<-c(NA)
                                                        return(data.frame(n,p,h))
                                                        }
                                                
                                                else {p<-c("All imput was correct")
                                                        n<-c(1)
                                                        return(data.frame(n,p,h))}
                                         }
                asN<-function(x){
                        f<-as.numeric(completer(x)$h)
                        return(f)
                }
                
                msg<-function(x){
                        return(levels(completer(x)$p))
                }
                
                lg<-function(x){
                        return(completer(x)$n[1])
                }
                
                stat<-function(mu){
                #fit<-fitdistr(mu-mean(mu),"normal") 
                chi<- chisq.test(mu)
                #Fit<-data.frame(fit$estimate)
                #Mean<-Fit$fit.estimate[1]
                #Sd<-Fit$fit.estimate[2]
                Mean<-mean(mu)
                Sd<-sd(mu)
                Chi<-chi$statistic
                P<-chi$p.value
                Len<-length(mu)
                frame<-data.frame(Mean,Sd,Chi,P,Len)
                names(frame)<-c("Mean","Standard_deviation","Chi_squared","p_value","Sequence_length")
                return(frame)
                }
                
                all<-reactive({paste(input$text10,input$text9,input$text8,input$text7,input$text6,input$text5,input$text4,input$text3,input$text2,input$text1,sep="")})
                mu<-reactive({asN(all())})
                
                
                output$text1<-renderText({
                        if(input$goButton == 0)
                        {"Waiting for imput"}
                        else if(input$goButton > 0)
                        { 
                        #mall<-paste(input$text10,input$text9,input$text8,input$text7,input$text6,input$text5,input$text4,input$text3,input$text2,input$text1)
                                
                        paste(msg(all()))
                        #paste(as.character(as.numeric((substring(mall, seq(1,nchar(mall),1), seq(1,nchar(mall),1)))))) 
                        }
                        
                        })
                
                
                output$newHist<-renderPlot({
                        
                        if(input$goButton == 0){
                                mu<-c(1,1,1,1,1,1,1,1,1,1)
                                data<-data.frame(mu)
                                names(data)<-"DEFAULT_numeric_set"
                                hi<-ggplot(data,aes(x=DEFAULT_numeric_set))+geom_histogram()
                                hi
                        } 
                        
                        else if(input$goButton>0){
                        
                        data<-data.frame(mu())
                        names(data)<-"numbers"
                        #ink<-data.frame(input$text10,input$text9,input$text8,input$text7,input$text6,input$text5,input$text4,input$text3,input$text2,input$text1)
                        #names(ink)<-c("i10","i9","i8","i7","i6","i5","i4","i3","i2","i1")
                        #data2<-sapply(ink,Compose(as.character,asN,mean))
                        
                        myplot1<-ggplot(data,aes(x=numbers))+geom_histogram()
                        myplot1
                        #myplot2<-ggplot(data2-mean(data),aes(x=names()))+geom_histogram()
                        #grid<-grid.arrange(myplot1,myplot2,nrow=2)
                        #grid
                        
                        
                        #hist(mu,xlab='Your number set',col='lightblue',main='Histogram of your Gaussian brain')
                        #curve(sqrt(length(mu))*dnorm(x, mean=Mean, sd=Sd), 
                        #col="darkblue", lwd=2, add=TRUE, yaxt="n")
                
                #input$goButton
                #isolate(
#{
        #hist(mu,xlab='Your number set',col='lightblue',main='Histogram of your Gaussian brain')
        #curve(sqrt(length(mu))*dnorm(x, mean=Mean, sd=Sd), 
        # col="darkblue", lwd=2, add=TRUE, yaxt="n")
        
#}



                #)
                
                        }
})
                

output$text2<-renderText({
        if(input$goButton == 0)
        paste("Waiting for input")
        
        else if(input$goButton>0)
        {paste(stat(mu())$Mean,stat(mu())$Standard_deviation)}
        

})

output$mytable1 = renderDataTable({
        quora<-stat(mu())
}, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))


#output$text3<-renderText({
 #       input$goButton
 #       isolate({
  #              
 #       }
   #     )
    #    isolate(paste(jMean,jSd))
  #      
  #      
#})

        }
)