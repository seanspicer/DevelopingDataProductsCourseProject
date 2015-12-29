amps = read.table("AmpsByPod.csv", sep=",", header = T);

amps$well = "Tmp";

for(i in 1:nrow(amps)) {
  
  if(amps$pod_num[i] <= 40)
  {
    amps$well[i] = "Deep";
  }
  else
  {
    amps$well[i] = "Shallow";
  }
  
}
