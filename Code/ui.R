library(shiny)

shinyUI(pageWithSidebar(
  
  #
  # Header
  #
  headerPanel("Determining Anelastic Rock Attenuation", windowTitle="Rock Attenuation App"),
  
  #
  # SideBar
  #
  sidebarPanel(
    h1("Overview"),
    p("In reflection seismology, the anelastic attenuation factor, often expressed as seismic quality factor or 
      Q (which is inversely proportional to attenuation factor), quantifies the effects of anelastic attenuation 
      on the seismic wavelet caused by fluid movement and grain boundary friction. As a seismic wave propagates 
      through a medium, the elastic energy associated with the wave is gradually absorbed by the medium, eventually 
      ending up as heat energy. This is known as absorption (or anelastic attenuation) and will eventually cause 
      the total disappearance of the seismic wave."),
    h4("The seismic Quality Factor, Q, is defined as: Q=2*PI*(E / Delta*E), where (E / Delta * E) is the fraction of 
      energy lost per cycle."),
    p("This app presents data recorded from a 40-level geophone array in a deep observation well, near a hydraulically
      fractured (Frac'd) well.  There are 4500 individual events recorded.  In practice, measurements do not yield
      sufficiently accurate measurements to determine the Dominant Frequency nor the Average Rock Velocity of the near
      wellbore environment.  Therefore, in order to determine Q, one must adjust these values in addition to Q, in order
      to flatten the scaled amplitudes - thereby removing effects of rock attenuation and spherical dispersion with distance."),

    h4("Change the controls below to alter the rock attenuation model."),
    sliderInput('avgVel', 'Average Rock Velocity (ft/sec)', value=13500, min=10000, max=18000, step=100),
    sliderInput('avgFrq', 'Dominant Frequency (Hz)', value=130, min=40, max=400, step=1),
    sliderInput('qval', 'Q', value=60, min=10, max=200, step=1)

  ),
  
  #
  # Main
  #
  mainPanel(
      
      plotOutput(outputId = 'rawAmps',  width = "100%"),
      p(""),
      p("Below, we plot scaled amplitudes based on the Average Rock Velocity, Dominent Frequency, and Rock Attenuation Q.
        The objective is to use the slider bars at left to make the fit line in RED as flat as possible."),
      plotOutput(outputId = 'correctedAmps',  width = "100%")

  )
  
));