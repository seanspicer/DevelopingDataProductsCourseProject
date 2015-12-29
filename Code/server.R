library(shiny)
library(ggplot2)

source('loadData.R')

shinyServer(
  function(input, output) {
    
    output$rawAmps <- renderPlot({
      ggplot(amps[amps$well == 'Deep',]) + 
        geom_point(aes(x=DistToGeophone, y=rms_signal.p)) + 
        xlab('Distance to Geophone') +
        ylab('Recorded Signal (microvolts)') +
        ggtitle('Uncorrected Amplitudes') +
        scale_y_log10();
    })
    
    output$correctedAmps <- renderPlot({
      
      # Correct for Q and spherical spreading
      amps$sphSpreadRemoved = amps$rms_signal.p*amps$DistToGeophone;
      amps$coef = (input$avgFrq * pi) / (input$qval * input$avgVel);
      amps$corAmp = amps$sphSpreadRemoved*exp(amps$coef*amps$DistToGeophone);
      
      # Find the best fit line
      fit <- lm(log(amps$corAmp) ~ amps$DistToGeophone);
      amps$vals <- exp(predict(fit, list(amps$DistToGeohpone)));
      
      ggplot(amps[amps$well == 'Deep',]) + 
        geom_point(aes(x=DistToGeophone, y=corAmp)) + 
        geom_line(aes(x=DistToGeophone, y=vals), color="Red", size=2) + 
        xlab('Distance to Geophone') +
        ylab('Scaled Amplitude') +
        ggtitle('Corrected Amplitudes') +
        scale_y_log10();
    })
    
  }
)