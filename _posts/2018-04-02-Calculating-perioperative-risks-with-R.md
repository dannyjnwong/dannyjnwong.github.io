---
title: "Calculating perioperative risks with R"
author: "Danny Wong"
date: "02 April, 2018"
layout: post
blog: true
tag:
- R
- coding
- Perioperative Medicine
---

One thing that we need to do quite frequently in my area of research is to calculate the perioperative risk of a patient undergoing surgery based on baseline factors, such as patient age, type of surgery, and presence of medical co-morbidities, etc.

There are a whole constellation of risk scoring/stratification tools which are available in [the literature](https://www.ncbi.nlm.nih.gov/pubmed/24195875). One of the risk tools that we most frequently use in our research group is the Physiological and Operative Severity Score for the enUmeration of Mortality and morbidity [(POSSUM)](http://onlinelibrary.wiley.com/doi/10.1002/bjs.1800780327/abstract), and its Portsmouth variation [(P-POSSUM)](https://onlinelibrary.wiley.com/doi/abs/10.1046/j.1365-2168.1998.00840.x).

I therefore wrote a couple of `R` functions to calculate these scores in my work, and I'll talk about them here.

The first calculates POSSUM morbidity, and P-POSSUM mortality risks (or more precisely, the log-odds). It parses a dataframe and computes the POSSUM scores, and thens return a dataframe, which you can assign to an object name, with the following variables:

  - `PhysScore`      The physiological score for POSSUM
  - `OpScore`        The operative score for POSSUM
  - `POSSUMLogit`    The log-odds for morbidity as calculated by POSSUM
  - `pPOSSUMLogit`   The log-odds for mortatlity as calculated by P-POSSUM

To use the function, there is some pre-processing that needs to be done to manipulate the input dataframe to have columns with the names and structure as below:

  - `Age`            continuous
  - `JVP`            binary, whether the patient has raised JVP or not
  - `Cardiomegaly`   binary, whether the patient has cardiomegaly on CXR or not
  - `Oedema`         binary, whether the patient has peripheral oedema or not
  - `Warfarin`       binary, whether the patient normally takes warfarin or not
  - `Diuretics`      binary, whether the patient normally takes a diuretic medication or not
  - `AntiAnginals`   binary, whether the patient normally takes anti-anginal medication or not
  - `Digoxin`        binary, whether the patient normally takes digoxin or not
  - `AntiHypertensives`  binary, whether the patient normally takes blood pressure meds or not
  - `Dyspnoea`       categorical, can be: Non = None; OME = On exertion; L = Limiting activities; AR = At rest
  - `Consolidation`  binary, whether the patient has consolidation on CXR
  - `PulmonaryFibrosis`  binary, whether the patient has a history of pulmonary fibrosis or imaging findings of fibrosis
  - `COPD`           binary, whether the patient has COPD or not
  - `SysBP`          continuous, pre-op systolic blood pressure (mmHg)
  - `HR`             continuous, pre-op pulse/heart rate
  - `GCS`            continuous, pre-op GCS
  - `Hb`             continuous, pre-op Hb (g/L)
  - `WCC`            continuous, pre-op White Cell Count (* 10^9cells/L)
  - `Ur`             continuous, pre-op Urea (mmol/L)
  - `Na`             continuous, pre-op Na (mmol/L)
  - `K`              continuous, pre-op K (mmol/L)
  - `ECG`            categorical, electrocardiogram, ND = Not done; NOR = Normal ECG; AF6090 = AF 60-90; AF>90 = AF>90; QW = Q-waves; 4E = >4 ectopics; ST = ST or T wave changes; O = Any other abnormal rhythm
  - `OpSeverity`     categorical, severity of the procedure, Min = Minor; Int = Intermediate; Maj = Major; Xma = Xmajor; Com = Complex
  - `ProcedureCount` categorical, 1 = 1; 2 = 2; GT2 = >2
  - `EBL`            categorical, estimated blood loss, 0 = 0-100ml; 101 = 101-500ml; 501 = 501-999ml; 1000 = >=1000
  - `PeritonealContamination`  categorical, NA = Not applicable; NS = No soiling; MS = Minor soiling; LP = Local pus; FBC = Free bowel content pus or blood
  - `Malignancy`     categorical, NM = Not malignant; PM = Primary malignancy only; MNM = Malignancy + nodal metastases; MDM = Malignancy + distal metastases
  - `OpUrgency`      categorical, NCEPOD operative urgency classifications. Ele = Elective; Exp = Expedited; U = Urgent; I = Immediate

The actual function uses `dplyr` as a dependency, and the code for the function is as follows:


{% highlight r %}
gen.POSSUM <- function(x){
  require(dplyr)
  
  #Compute the physiological score
  possum.df <- x %>% 
    mutate(AgeCat = cut(Age, breaks = c(0,60,70, Inf))) %>%
    mutate(AgeScore = ifelse(AgeCat == "(0,60]", 1,
                             ifelse(AgeCat == "(60,70]", 2, 
                                    ifelse(AgeCat == "(70,Inf]", 4, NA)))) %>%
    mutate(CardioScore = ifelse((JVP %in% c("Y", "1", "TRUE") |
                                   Cardiomegaly %in% c("Y", "1", "TRUE")), 8,
                                ifelse((Oedema %in% c("Y", "1", "TRUE") | 
                                          Warfarin %in% c("Y", "1", "TRUE")), 4,
                                       ifelse((Diuretics %in% c("Y", "1", "TRUE") | 
                                                 AntiAnginals %in% c("Y", "1", "TRUE") | 
                                                 Digoxin %in% c("Y", "1", "TRUE") | 
                                                 AntiHypertensives %in% c("Y", "1", "TRUE")), 2, 1)))) %>%
    mutate(RespScore = ifelse((Dyspnoea %in% "AR" |
                                 Consolidation %in% c("Y", "1", "TRUE") |
                                 PulmonaryFibrosis %in% c("Y", "1", "TRUE")), 8, 
                              ifelse((Dyspnoea %in% "L" |
                                        COPD %in% c("Y", "1", "TRUE")), 4, 
                                     ifelse((Dyspnoea %in% "OME"), 2, 1)))) %>%
    mutate(BPCat = cut(SysBP, breaks = c(0, 89, 99, 109, 130, 170, Inf))) %>%
    mutate(BPScore = ifelse((BPCat %in% "(0,89]"), 8, 
                            ifelse((BPCat %in% "(170,Inf]" | BPCat %in% "(89,99]"), 4,
                                   ifelse((BPCat %in% "(130,170]" | BPCat %in% "(99,109]"), 2, 1)))) %>%
    mutate(HRCat = cut(HR, breaks = c(0, 39, 49, 80, 100, 120, Inf))) %>%
    mutate(HRScore = ifelse((HRCat %in% "(0,39]" | HRCat %in% "(120,Inf]"), 8, 
                               ifelse((HRCat %in% "(100,120]"), 4,
                                      ifelse((HRCat %in% "(39,49]" | HRCat %in% "(80,100]"), 2, 1)))) %>%
    mutate(GCSCat = cut(GCS, breaks = c(0, 8, 11, 14, Inf))) %>%
    mutate(GCSScore = ifelse((GCSCat %in% "(0,8]"), 8, 
                             ifelse((GCSCat %in% "(8,11]"), 4,
                                    ifelse((GCSCat %in% "(11,14]"), 2, 1)))) %>%
    mutate(HbCat = cut(Hb, breaks = c(0, 9.9, 11.4, 12.9, 16, 17, 18, Inf))) %>%
    mutate(HbScore = ifelse((HbCat %in% "(0,9.9]" | HbCat %in% "(18,Inf]"), 8, 
                            ifelse((HbCat %in% "(9.9,11.4]" | HbCat %in% "(17,18]"), 4,
                                   ifelse((HbCat %in% "(11.4,12.9]" | HbCat %in% "(16,17]"), 2, 1)))) %>%
    mutate(WCCCat = cut(WCC, breaks = c(0, 3, 4, 10, 20, Inf))) %>%
    mutate(WCCScore = ifelse((WCCCat %in% "(0,3]" | WCCCat %in% "(20,Inf]"), 4, 
                             ifelse((GCSCat %in% "(10,20]" | GCSCat %in% "(3,4]"), 2, 1))) %>%
    mutate(UrCat = cut(Ur, breaks = c(0, 7.5, 10, 15, Inf))) %>%
    mutate(UrScore = ifelse((UrCat %in% "(15,Inf]"), 8, 
                            ifelse((UrCat %in% "(10,15]"), 4,
                                   ifelse((UrCat %in% "(7.5,10]"), 2, 1)))) %>%
    mutate(NaCat = cut(Na, breaks = c(0, 125, 130, 135, Inf))) %>%
    mutate(NaScore = ifelse((NaCat %in% "(0,125]"), 8, 
                            ifelse((NaCat %in% "(125,130]"), 4,
                                   ifelse((NaCat %in% "(130,135]"), 2, 1)))) %>%
    mutate(KCat = cut(K, breaks = c(0, 2.8, 3.1, 3.4, 5, 5.3, 5.9,  Inf))) %>%
    mutate(KScore = ifelse((KCat %in% "(0,2.8]" | KCat %in% "(5.9, Inf]"), 8, 
                           ifelse((KCat %in% "(2.8,3.1]" | KCat %in% "(5.3,5.9]"), 4,
                                  ifelse((KCat %in% "(3.1,3.4]" | KCat %in% "(5,5.3]"), 2, 1)))) %>%
    mutate(ECGScore = ifelse((ECG %in% c("AF>90", "QW", "4E", "ST", "O")), 8,
                             ifelse((ECG %in% "AF6090"), 4, 1))) %>%
    mutate(PhysScore = AgeScore + CardioScore + RespScore + HRScore + GCSScore + HbScore + WCCScore + UrScore + NaScore + KScore + ECGScore)
  
  #Next compute Operative score
  possum.df <- possum.df %>%
    mutate(OpSeverityScore = ifelse((OpSeverity %in% c("Xma", "Com")), 8, 
                                    ifelse((OpSeverity %in% "Maj"), 4,
                                           ifelse((OpSeverity %in% "Int"), 2, 1)))) %>%
    mutate(MultiProcedureScore = ifelse((ProcedureCount %in% "GT2"), 8,
                                        ifelse((ProcedureCount %in% "2"), 4, 1))) %>%
    mutate(EBLScore = ifelse((EBL %in% "1000"), 8,
                             ifelse((EBL %in% "501"), 4,
                                    ifelse((EBL %in% "101"), 2, 1)))) %>%
    mutate(SoilingScore = ifelse((PeritonealContamination %in% "FBC"), 8,
                                 ifelse((PeritonealContamination %in% "LP"), 4,
                                        ifelse((PeritonealContamination %in% "MS"), 2, 1)))) %>%
    mutate(MalignancyScore = ifelse((Malignancy %in% "MDM"), 8,
                                    ifelse((Malignancy %in% "MNM"), 4,
                                           ifelse((Malignancy %in% "PM"), 2, 1)))) %>%
    mutate(UrgencyScore = ifelse((OpUrgency %in% "I"), 8,
                                 ifelse((OpUrgency %in% "U"), 4, 1))) %>%
    mutate(OpScore = OpSeverityScore + MultiProcedureScore + EBLScore + SoilingScore + MalignancyScore + UrgencyScore)
  
  #Now compute the POSSUM and pPOSSUM logit values
  possum.df <- possum.df %>%
    mutate(pPOSSUMLogit = -9.065 + (0.1692 * PhysScore)+ (0.1550 * OpScore)) %>%
    mutate(POSSUMLogit = -5.91 + (0.16 * PhysScore)+ (0.19 * OpScore))
  
  possum.df <- possum.df %>%
    select(PhysScore, OpScore, POSSUMLogit, pPOSSUMLogit)
  
  return(possum.df)
}
{% endhighlight %}

Let's see it in action:


{% highlight r %}
#Let's create a fake dataset with 5 patients
test_data <- data.frame(
  Age = c(25, 40, 60, 75, 90),
  JVP = c(0, 1, 1, 0, 1),
  Cardiomegaly = c(0, 0, 0, 1, 1),
  Oedema = c(0, 0, 0, 1, 1),
  Warfarin = c(0, 0, 0, 0, 1),
  Diuretics = c(0, 0, 1, 0, 0),
  AntiAnginals = c(0, 0, 1, 0, 0),
  Digoxin = c(0, 0, 0, 0, 0),
  AntiHypertensives = c("N", "Y", "N", "N", "Y"),
  Dyspnoea = c(FALSE, FALSE, FALSE, TRUE, FALSE),
  Consolidation = c(0, 0, 0, 0, 0),
  PulmonaryFibrosis = c("N", "N", "N", "N", "N"),
  COPD = c(0, 0, 0, 1, 0),
  SysBP = c(120, 117, 140, 123, 118),
  HR = c(45, 51, 65, 50, 90),
  GCS = c(15, 15, 15, 15, 14),
  Hb = c(13.1, 12.6, 8.9, 8.0, 11.6),
  WCC = c(4.5, 4.3, 2.6, 14.1, 11.2),
  Ur = c(4.3, 4.6, 5.7, 8.1, 6.5),
  Na = c(131, 134, 155, 141, 142),
  K = c(3.7, 4.5, 4.4, 5.1, 5.8),
  ECG = c("NOR", "AF6090", "NOR", "AF>90", "NOR"),
  OpSeverity = c("Min", "Int", "Xma", "Com", "Maj"),
  ProcedureCount = c("GT2", "1", "1", "2", "1"),
  EBL = c(0, 101, 0, 501, 1000),
  PeritonealContamination = c("NA", "NS", "NS", "MS", "LP"),
  Malignancy = c("NM", "PM", "NM", "PM", "MDM"),
  OpUrgency = c("Ele", "Ele", "Exp", "U", "Ele")
  )

head(test_data)
{% endhighlight %}



{% highlight text %}
##   Age JVP Cardiomegaly Oedema Warfarin Diuretics AntiAnginals Digoxin
## 1  25   0            0      0        0         0            0       0
## 2  40   1            0      0        0         0            0       0
## 3  60   1            0      0        0         1            1       0
## 4  75   0            1      1        0         0            0       0
## 5  90   1            1      1        1         0            0       0
##   AntiHypertensives Dyspnoea Consolidation PulmonaryFibrosis COPD SysBP HR
## 1                 N    FALSE             0                 N    0   120 45
## 2                 Y    FALSE             0                 N    0   117 51
## 3                 N    FALSE             0                 N    0   140 65
## 4                 N     TRUE             0                 N    1   123 50
## 5                 Y    FALSE             0                 N    0   118 90
##   GCS   Hb  WCC  Ur  Na   K    ECG OpSeverity ProcedureCount  EBL
## 1  15 13.1  4.5 4.3 131 3.7    NOR        Min            GT2    0
## 2  15 12.6  4.3 4.6 134 4.5 AF6090        Int              1  101
## 3  15  8.9  2.6 5.7 155 4.4    NOR        Xma              1    0
## 4  15  8.0 14.1 8.1 141 5.1  AF>90        Com              2  501
## 5  14 11.6 11.2 6.5 142 5.8    NOR        Maj              1 1000
##   PeritonealContamination Malignancy OpUrgency
## 1                      NA         NM       Ele
## 2                      NS         PM       Ele
## 3                      NS         NM       Exp
## 4                      MS         PM         U
## 5                      LP        MDM       Ele
{% endhighlight %}

Notice that I have set the binary variables in three different ways: as `0`s and `1`s, `N`s and `Y`s, and `FALSE`s and `TRUE`s. The function should parse any of these correctly.


{% highlight r %}
#Let's run run the function with the test data
test_output <- gen.POSSUM(test_data)

test_output
{% endhighlight %}



{% highlight text %}
##   PhysScore OpScore POSSUMLogit pPOSSUMLogit
## 1        13      13       -1.36      -4.8504
## 2        23       9       -0.52      -3.7784
## 3        28      13        1.04      -2.3124
## 4        40      24        5.05       1.4230
## 5        27      26        3.35      -0.4666
{% endhighlight %}

In order to convert the computed log-odds into probability risks, we can use the `invlogit` function from the `arm` package


{% highlight r %}
test_output$POSSUMProb <- arm::invlogit(test_output$POSSUMLogit)

test_output$pPOSSUMProb <- arm::invlogit(test_output$pPOSSUMLogit)

test_output
{% endhighlight %}



{% highlight text %}
##   PhysScore OpScore POSSUMLogit pPOSSUMLogit POSSUMProb pPOSSUMProb
## 1        13      13       -1.36      -4.8504  0.2042403 0.007764488
## 2        23       9       -0.52      -3.7784  0.3728522 0.022348370
## 3        28      13        1.04      -2.3124  0.7388500 0.090101192
## 4        40      24        5.05       1.4230  0.9936315 0.805808291
## 5        27      26        3.35      -0.4666  0.9661048 0.385421293
{% endhighlight %}


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.4.2 (2017-09-28)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
## 
## Matrix products: default
## 
## locale:
## [1] LC_COLLATE=English_United Kingdom.1252 
## [2] LC_CTYPE=English_United Kingdom.1252   
## [3] LC_MONETARY=English_United Kingdom.1252
## [4] LC_NUMERIC=C                           
## [5] LC_TIME=English_United Kingdom.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.17   bindrcpp_0.2 dplyr_0.7.4  sp_1.2-3    
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.14     bindr_0.1        magrittr_1.5     splines_3.4.2   
##  [5] MASS_7.3-47      munsell_0.4.3    colorspace_1.2-6 arm_1.9-1       
##  [9] lattice_0.20-35  R6_2.1.2         rlang_0.1.4      minqa_1.2.4     
## [13] highr_0.6        stringr_1.2.0    plyr_1.8.4       tools_3.4.2     
## [17] grid_3.4.2       nlme_3.1-131     gtable_0.2.0     coda_0.18-1     
## [21] abind_1.4-5      lme4_1.1-13      yaml_2.1.14      lazyeval_0.2.0  
## [25] assertthat_0.1   tibble_1.3.4     Matrix_1.2-11    nloptr_1.0.4    
## [29] ggplot2_2.2.1    evaluate_0.10.1  glue_1.1.1       stringi_1.1.1   
## [33] compiler_3.4.2   scales_0.5.0     pkgconfig_2.0.1
{% endhighlight %}
