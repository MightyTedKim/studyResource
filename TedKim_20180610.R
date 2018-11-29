library(tibble)
library(readxl)
library(xts)
library(dplyr)
library(dygraphs)

# FUNCTIONS FOR SALES REPORT
#==============================
# 1. data set for specific stock number
F_sales_by_stk<- function(DATA1, STK) {
  DATA2 <- DATA1 %>%
    filter(Stk_Nbr_Uniq == STK)
  return(DATA2)
}
# 2. data set for specific stock number and single week
F_sales_by_Stk_weekSingle <- function(DATA1, STK, WEEK) {
  DATA2 <- DATA1 %>%
    filter(Stk_Nbr_Uniq == STK & `WM Week` == WEEK )
  return(DATA2)
}
# 3. data set for specific stock number and accumulated week
F_sales_by_Stk_weekAccu <- function(DATA1, STK, WEEK) {
  DATA2 <- DATA1 %>%
    filter(Stk_Nbr_Uniq == STK & `WM Week` < WEEK + 1)
  return(DATA2)
}

#=SHORT==========================
# basic
sellthru <- function(DATA) {
  round(sum(DATA$`POS Qty`) / sum(DATA$`Gross Ship Qty`) * 100, 1)
}
#=ETC==========================
SORT_SIZE <- function(DATA1) {
  DATA2=NULL
  SORT_SIZE = read_excel("SORT.xlsx", sheet = "size", na = "NA")
  MERGE1 = merge(DATA1, SORT_SIZE, by=  "Size Desc")
  MERGE2 <- as_tibble(MERGE1) # I like tibble
  MERGE3 = MERGE2[order(MERGE2$size_sort),]
  DATA2 = MERGE3[,1:ncol(MERGE1)]
  return(DATA2)
}

sort_week <- function(DATA1) {
  DATA2 = NULL
  SORT_WEEK = read_excel("SORT.xlsx", sheet = "week", na = "NA")
  MERGE1 = merge(SORT_WEEK, DATA1, by= "WM Week")
  DATA2 <- as_tibble(MERGE1) # I like tibble
  return(DATA2)
}

sort_fullyear_week <- function(DATA1) {
  DATA2 = NULL
  SORT_WEEK = read_excel("SORT.xlsx", sheet = "week", na = "NA")
  MERGE1 = merge(SORT_WEEK, DATA1, by= "WM Week", all.x = TRUE) # empty data as NA
  DATA2 <- as_tibble(MERGE1) # I like tibble
  DATA2[is.na(DATA2)] <- 0 # NA as 0
  return(DATA2)
}

size_group <- function(DATA1) {
  DATA2=NULL
  SORT_SIZE = read_excel("SORT.xlsx", sheet = "size", na = "NA")
  MERGE1 = merge(DATA1, SORT_SIZE, by=  "Size Desc")
  MERGE2 <- as_tibble(MERGE1) # I like tibble
  MERGE3 = MERGE2[order(MERGE2$size_group),]
  DATA2 = MERGE3[,1:ncol(MERGE1)]
  return(DATA2)
}
#===========================


# 1st page
#1
pieChart_FL <- function(DATA1) {
DATA2 <- DATA1 %>% # DATA2
  filter(!is.na(`POS Qty`)) %>%
  group_by(`Fineline Number`) %>%
  summarise(sumQty = sum(`POS Qty`))

ggplot(DATA2, aes( x ="", y = sumQty, fill = `Fineline Number`))+
  geom_bar(width = 1, stat = "identity", color ="white") +
  theme_void()+
  
  theme( axis.line = element_blank(),
         plot.title = element_text(hjust = 0.5),
         legend.position = "none",
         legend.justification = c(0,0),
         legend.title = element_blank()) +
  
  geom_text(aes (label = format(sumQty, big.mark=",")), 
            size = 7,   colour = "white",
            hjust = 0.6,  vjust = 0,
            position = position_stack(vjust = 0.5))+
  geom_text(aes (label = paste0("(",round(sumQty/sum(sumQty)*100, 2), "%)")), 
            size = 4,   colour = "white",
            hjust = 0.5,  vjust = 1.5,
            position = position_stack(vjust = 0.5))+
  
  coord_polar(theta = "y", start=0)
}
#2
lineChart_FL <- function(DATA1) {
  DATA2 <- DATA1 %>% # DATA2
    filter(!is.na(`POS Qty`)) %>%
    group_by(`Fineline Number`, `WM Week`) %>%
    summarise(sumQty = sum(`POS Qty`))
  
  PLOT1 <- ggplot(DATA2, # PLOT1
                  aes(x = as.factor(as.character(`WM Week`)),
                      y = sumQty))
  
  LINE1 <- PLOT1 + # LINE1
    geom_line(stat = "identity", aes(colour = `Fineline Number`, group = `Fineline Number`))+
    labs(title = "WM Week Vs POSQty, FL", caption = "") +
    xlab("  ")+ ylab(" ") +
    theme(legend.position=c(0.12, 0.85),
          axis.text.x = element_text(angle = 60, vjust =0.5),
          plot.margin=unit(c(0.5,0.5,0.7,0.5),"cm"))
  # margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
  LINE1
}
#3
facetWrap_Setting <- function(DATA1) {

  MINWEEK = min(DATA1$`WM Week`)
  MEDWEEK = median(DATA1$`WM Week`)
  MAXWEEK = max(DATA1$`WM Week`)
  
  facetWrap_setting <- ggplot(DATA2, aes(x = `WM Week`, y = sumQty)) +
    geom_bar(stat = "identity", aes(colour = Stk_Nbr_Uniq, fill = Stk_Nbr_Uniq))+
    
    scale_x_discrete(breaks = c(MINWEEK, MEDWEEK, MAXWEEK),
                     labels = c(substr(MINWEEK,5,6),
                                        MEDWEEK, MAXWEEK))+
    theme(legend.title = element_blank(),
          axis.text.x = element_text(angle = 20, hjust = +1),
          plot.margin = unit(c(.5,.5,1,.5), "cm")
      # margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
          )+
    xlab("") + ylab("      ")
  
  facetWrap_setting
}
#===========================
# 2nd, 3rd page
#1
colorTable <- function(DATA1) {
  DATA2 <- DATA1 %>%
    filter(!is.na(`POS Qty`)) %>%
    group_by(`Color Desc`) %>%
    summarise(sumQty = sum(`POS Qty`)) %>%
    arrange(-sumQty) %>%
    mutate(ratio = round(     (sumQty/ sum(sumQty) * 100),   0)     )
  
  return(DATA2)
}

#2
colorKable <- function(DATA) { 
  rowNumber = nrow(DATA)
  ForwardRowNumber = rowNumber - 2
  
  kable(DATA, "html") %>%
    kable_styling(bootstrap_options = "striped", full_width = F, position = "left") %>%
    row_spec(1:3, bold = T, color = "white", background = "steelblue") %>%
    row_spec(ForwardRowNumber:rowNumber, bold = T, color = "white", background = "chocolate")
}

#3  
colorBarPlot <- function(DATA) {
  ggplot(DATA, aes( x = reorder(`Color Desc`,-sumQty), y = sumQty, fill = `Color Desc`))+
    geom_bar(width = 1, stat = "identity", colour = "white", size = 2) +
    
    geom_text(aes (label = format(sumQty, big.mark=",")), 
              size = 3,   colour = "black",
              hjust = 0.5,  vjust = 0.5,
              position = position_stack(vjust = 0.7))+
    
    geom_text(aes (label = paste0("(", ratio, "%)")), 
              size = 3,   colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 0.3))+
    
    xlab(NULL) + ylab("    ") +
    theme(legend.position = "bottom") # not working in function
}

#===========================
# 3rd page
#1 sellthru TABLE LW 
sellthruTable_LW <- function(DATA1) {
  DATA2 <- DATA1 %>%  # LW: table
    filter(!is.na(`POS Qty`))%>%
    group_by(`Color Desc`, `Vendor Stk Nbr`) %>%
    summarise(
      sumOnHand = sum(`Curr Str On Hand Qty`), # can only be seen on weekly data
      sumPOSQTY = sum(`POS Qty`),
      sumGrossShipQTY = sum(`Gross Ship Qty`)
    ) %>%
    arrange(`Vendor Stk Nbr`)
  
  DATA2 <- mutate(DATA2, # LWSellthru =  POSQTY / ( POSQTY + OHQTY)
                     LW_sellThr = sumPOSQTY/
                    (sumPOSQTY + sumOnHand)) 
  
  DATA2 <- mutate(DATA2, # LWWOS = POSQTY/ (POSQTY + OHQTY)
                     LW_WOS = round(sumPOSQTY/
                         sumGrossShipQTY * 100,2)) 
  return(DATA2)
}

#2 sellthru KABLE LW
sellthruKable_LW <- function(Data) {

kable(Data[,2:ncol(Data)], "html") %>%
  kable_styling(bootstrap_options = "striped", full_width = F, position = "left", font_size = 10) %>%
  row_spec(1:nrow(Data), bold = T, color = "white", background = "steelblue") %>%
  column_spec(1, bold = T, border_right = T) %>%
  column_spec(ncol(Data) - 3, bold = T, border_right = T) 
}

#3 sellthru PLOT LW
sellthruPlot_LW <- function(Data) {
  
  is.na(DATA)<-sapply(DATA, is.infinite) # NAN    
  DATA [is.na(DATA)]<-0 # INF    
  
  MAXRATIO = max(DATA$LW_WOS)
  MAXBAR = max(DATA$sumPOSQTY)
  #=================================
  # PLOT
  ggplot(DATA,aes(x = `Vendor Stk Nbr`, fill = `Vendor Stk Nbr`)) + # DATA
    geom_bar(aes(y = sumPOSQTY * MAXRATIO/MAXBAR), stat = "identity") + # MAXRATIO/MAXBAR    
    
    geom_line(aes(y = LW_WOS), group = 1) +     
    geom_point(aes(y = LW_WOS), size = 3, shape = 21, fill = "white") +    
    
    geom_text(aes (x = `Vendor Stk Nbr`, y = LW_WOS,
                   label = paste0("(", LW_WOS, "%)")), 
              size = 4, colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 1)) +
    
    geom_text(aes (x= `Vendor Stk Nbr`, y = sumPOSQTY * MAXRATIO/MAXBAR, # MAXRATIO/MAXBAR
                   label = format(sumPOSQTY, big.mark=",")), 
              size = 3,   colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 0.4)) +
    xlab(NULL) + ylab("    ") +
    theme(legend.position = "bottom",
          axis.text.x = element_text(angle = 20))  
  
}
#========================================================
#1 sellthru STK TABLE
sellthruTable <- function(DATA1){
  DATA2 <- DATA1%>%
    filter(!is.na(`POS Qty`))%>%
    group_by(`Color Desc`, `Vendor Stk Nbr`) %>%
    summarise(
      sumPOSQTY = sum(`POS Qty`),
      sumGrossShipQTY = sum(`Gross Ship Qty`)
      # WOS = POSQTY/ GrossShipQTY
    ) %>%
    arrange(`Vendor Stk Nbr`)
  
  DATA2 <- mutate(DATA2, sellthru = 
                    round(sumPOSQTY/sumGrossShipQTY * 100, 2))
  # std sell thru = POSQTY/GrossShipQTY
  return(DATA2)
}
  
#2 sellthru STK KABLE
sellthruKable <- function(DATA){
  kable(DATA[,2:ncol(DATA)], "html") %>%
    kable_styling(bootstrap_options = "striped", full_width = F, position = "left") %>%
    row_spec(1:nrow(DATA), bold = T, color = "white", background = "steelblue") %>%
    column_spec(1, bold = T, border_right = T) %>%
    column_spec(ncol(DATA) - 2, bold = T, border_right = T) 
}
#3 sellthru STK PLOT
sellthruPlot <- function(DATA){
  is.na(DATA)<-sapply(DATA, is.infinite) # NAN -> 0  
  DATA [is.na(DATA)]<-0 # INF -> 0
  
  MAXRATIO = max(DATA$sellthru)
  MAXBAR = max(DATA$sumPOSQTY)
  #=================================
  
  ggplot(DATA,aes(x = `Vendor Stk Nbr`, fill = "")) + # fill = `Vendor Stk Nbr`
    geom_bar(aes(y = sumPOSQTY * MAXRATIO/MAXBAR), stat = "identity") + 
    
    geom_line(aes(y = sellthru), group = 1) + 
    geom_point(aes(y = sellthru), size = 3, shape = 21, fill = "white") +
    
    geom_text(aes (x = `Vendor Stk Nbr`, y = sellthru,
                   label = paste0("(", sellthru, "%)")), 
              size = 4, colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 1)) +
    
    geom_text(aes (x= `Vendor Stk Nbr`, y = sumPOSQTY* MAXRATIO/MAXBAR, 
                   label = format(sumPOSQTY, big.mark=",")),
              size = 3,   colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 0.3)) +
    theme(legend.position = "none",
          axis.text.x = element_text(angle = 20))
}

#============================================================
#1 Size TABLE
sellthruTable_SIZE <- function(DATA1){
  DATA2 <- DATA1 %>%
    filter(!is.na(`POS Qty`))%>%
    group_by(`Size Desc`) %>%
    summarise(
      sumPOSQTY = sum(`POS Qty`),
      sumGrossShipQTY = sum(`Gross Ship Qty`)
    ) %>%
    arrange(desc(`Size Desc`))
  # sell thru
  DATA2 <- mutate(DATA2, sellthru = round(sumPOSQTY/sumGrossShipQTY * 100, 2)) 
  DATA3 <- SORT_SIZE(DATA2)
  return(DATA3)
}

#2 Size KABLE
sellthruKable_SIZE <- function(DATA){
  kable(DATA, "html") %>%
    kable_styling(bootstrap_options = "striped", full_width = F, position = "left") %>%
    row_spec(1:nrow(DATA), bold = T, color = "white", background = "steelblue") %>%
    column_spec(1, bold = T, border_right = T) %>%
    column_spec(ncol(DATA) - 1, bold = T, border_right = T)
}

#3 Size PLOT
sellthruPlot_SIZE <- function(DATA){
  
  DATA$`Size Desc`<- as.factor(DATA$`Size Desc`)
  levels(DATA$`Size Desc`) <- DATA$`Size Desc`
  
  is.na(DATA)<-sapply(DATA, is.infinite) # NAN -> 0  
  DATA [is.na(DATA)]<-0 # INF -> 0
  
  MAXRATIO = max(DATA$sellthru)
  MAXBAR = max(DATA$sumPOSQTY)
  #=================================
  ggplot(DATA, aes(x = `Size Desc`)) + # DATA
    geom_bar(aes(y = sumPOSQTY * MAXRATIO/MAXBAR, fill = ""), stat = "identity") + 
    geom_line(aes(y = sellthru), group = 1) + 
    geom_point(aes(y = sellthru), size = 3, shape = 21, fill = "white") +
    
    geom_text(aes (x = `Size Desc`, y = sellthru,
                   label = paste0("(", sellthru, "%)")), 
              size = 4, colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 1)) +
    
    geom_text(aes (x= `Size Desc`, y = sumPOSQTY* MAXRATIO/MAXBAR, 
                   label = format(sumPOSQTY, big.mark=",")), 
              size = 3,   colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 0.3))  +
    theme(legend.position = "none")+ 
    guides(fill = guide_legend(nrow = 1))
}


#============================================================
#1 Zone TABLE
sellthruTable_Zone <- function(DATA1){
  DATA2 <- DATA1 %>%
    filter(!is.na(`POS Qty`))%>%
    group_by(`MDSE Major Zone`) %>%
    summarise(
      sumPOSQTY = sum(`POS Qty`),
      sumGrossShipQTY = sum(`Gross Ship Qty`)
    ) 
  # sell thru
  DATA2 <- mutate(DATA2, sellthru = round(sumPOSQTY/sumGrossShipQTY * 100, 2)) # std sell thru = POSQTY/GrossShipQTYsales_STD_zone
  return(DATA2) 
}

#2 Zone KABLE
sellthruKable_Zone <- function(DATA){
  kable(DATA, "html") %>%
    kable_styling(bootstrap_options = "striped", full_width = F, position = "left") %>%
    row_spec(1:nrow(DATA), bold = T, color = "white", background = "steelblue") %>%
    column_spec(1, bold = T, border_right = T) %>%
    column_spec(ncol(DATA)-1, bold = T, border_right = T) 
}
#3 Zone PLOT
sellthruKable_Plot <- function(DATA){
  is.na(DATA)<-sapply(DATA, is.infinite) # NAN    
  DATA [is.na(DATA)]<-0 # INF    
  
  MAXRATIO = max(DATA$sellthru)
  MAXBAR = max(DATA$sumPOSQTY)
  #=================================
  
  ggplot(DATA,aes(x = `MDSE Major Zone`)) +
    geom_bar(aes(y = sumPOSQTY * MAXRATIO/MAXBAR, fill = ""), stat = "identity") + 
    geom_line(aes(y = sellthru), group = 1) + 
    geom_point(aes(y = sellthru), size = 3, shape = 21, fill = "white") +
    
    geom_text(aes (x = `MDSE Major Zone`, y = sellthru, label = paste0("(", sellthru, "%)")), 
              size = 4, colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 1)) +
    
    geom_text(aes (x= `MDSE Major Zone`, y = sumPOSQTY* MAXRATIO/MAXBAR, label = format(sumPOSQTY, big.mark=",")), 
              size = 3,   colour = "black",
              hjust = 0.5,  vjust = 1,
              position = position_stack(vjust = 0.3)) +
    theme(legend.position = "none") + 
    guides(fill = guide_legend(nrow = 1))
}

# =xts data===========================================
# use when there r full continous week data
XTS_DATA1 <- function(DATA1) {
  DATA2 <- DATA1 %>%
    group_by(`WM Week`) %>% # no filter by stock
    summarise(SUM_POSQTY = sum(`POS Qty`))
  
  DATA3 = sort_week(DATA2)
  DATA3$WM_DATE <- as.Date(as.POSIXct(DATA3$WM_DATE, 'GMT'))

  DATA4 <- xts(DATA3[,c(1,3)], 
               order.by = as.Date(DATA3$WM_DATE))
  return(DATA4)
}


XTS_DATA2 <- function(DATA1, STK) {
  DATA2 <- DATA1 %>%
    filter(Stk_Nbr_Uniq == STK) %>% # filter by stock
    group_by(`WM Week`) %>%
    summarise(SUM_POSQTY = sum(`POS Qty`))
  
  DATA3 = sort_week(DATA2)
  
  DATA3$WM_DATE <- as.Date(as.POSIXct(DATA3$WM_DATE, 'GMT'))
  
  DATA4 <- xts(DATA3[,c(1,3)], 
               order.by = as.Date(DATA3$WM_DATE))
  return(DATA4)
}

#------------------------------------------
# use when there are missing week
XTS_fullyear_DATA1 <- function(DATA1) { 
  DATA2 <- DATA1 %>%
    group_by(`WM Week`) %>% # no filter by stock
    summarise(SUM_POSQTY = sum(`POS Qty`))
  
  DATA3 = sort_fullyear_week(DATA2) # giving NA Value
  DATA3$WM_DATE <- as.Date(as.POSIXct(DATA3$WM_DATE, 'GMT'))
  
  DATA4 <- xts(DATA3[,c(1,3)],
               order.by = as.Date(DATA3$WM_DATE))
  return(DATA4)
}


XTS_fullyear_DATA2 <- function(DATA1, STK) { 
  DATA2 <- DATA1 %>%
    filter(Stk_Nbr_Uniq == STK) %>% # filter by stock
    group_by(`WM Week`) %>%
    summarise(SUM_POSQTY = sum(`POS Qty`))
  
  DATA3 = sort_fullyear_week(DATA2) # giving NA Value
  DATA3$WM_DATE <- as.Date(as.POSIXct(DATA3$WM_DATE, 'GMT'))
  
  DATA4 <- xts(DATA3[,c(1,3)],
               order.by = as.Date(DATA3$WM_DATE))
  return(DATA4)
}
