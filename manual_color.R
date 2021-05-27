
#Made to manually change just one single color in ggplot


library(ggplot2)
  
conditions <- levels(Bio.Rep.Summary$Condition)
print(conditions) 
conditions[1]

for(i in 1:length(conditions)){

 cond.i <- subset(Bio.Rep.Summary, Condition == conditions[i])
 #cond.i <- subset(cond.i, Strain %in% c("arl1", "BY4741"))
  
#20210527 adding black as WT
color.list <-  scales::hue_pal()(length(unique(cond.i$Strain)))    
color.list[which(grepl("BY4741", unique(cond.i$Strain)))] <- "black"
show_col(color.list)

graphic.title <- conditions[i]

p <- ggplot(cond.i, aes(x=Time, y=OD600, group=Strain, colour=Strain))+
  geom_line(size=3)+
  scale_colour_manual(values=color.list)+ #only prints black line...
  geom_errorbar(aes(ymin=OD600-se, ymax=OD600+se), width=.1)+
  theme(legend.title =element_text(size = 25, face="bold" ),
                 legend.text= element_text(size=20, face="bold"),
                 title=element_text(size= 25, face= "bold"),
                 axis.text.x = element_text(size=16),
                 axis.text.y = element_text(size=16),
                 axis.ticks.length =unit(0.3, "cm"))+
  
  labs(title= graphic.title, 
       x="Time(h)",
       y="Cell Density (OD600)", 
       element_text(size=15, face="bold"))
  
print(p)  
} #end of for loop cond




#subset multiple
