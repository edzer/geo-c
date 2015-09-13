---
title: "GEO-C Kick-Off course, Castellon, Sept 15, 2015: Geostatistics" 
output:
  html_document:
    toc: true
    theme: united
---

[CC-BY-SA](http://creativecommons.org/licenses/by-sa/4.0/), Edzer Pebesma 2015.

# Science

Science is about gathering and communicating facts about the world, or theories and abstractions of it. Scientists do this by using methods that are accepted by, or acceptable to, other scientists.

## How does science work?

You can make discoveries on your own, but they only become part of science after you successfully communicate them. Acceptance comes after peer review, the process where (anonymous) experts evaluate your (written) work, and accept it (not necessarily as _truth_, but as proper scientific work).

Generally, there are two pathways for gathering knowledge deduction and induction.

## Deduction
Deduction start from first principles (axioms) and derives consequences, within the framework of these axioms. Example are found e.g. in Euclidean geometry. In this framework, one can proof things: if the axioms are true, then some facts deriviing from it must also be true. Logic, mathematics.

## Induction
Induction works the other way around: we confront ideas (hypotheses, _possible truths_) with observations on the real world, and try to choose the best. Along this path, one cannot find absolute truth, but only gain evidence for one hypothesis over the other. The principle is that of _falsification_ (due to Popper): using observation, we try to falsify hypothesis A in favour of hypothesis B. That doesn't make B true, but the best hypothesis around, until hypothesis C defies B. Natural sciences, social sciences. The science area that is concerned with probabilistic statements about hypothesis is statistics. The science area that predicts the frequencies of outcomes of observation, given knowlegde of the truth, is probability.

# Data analysis

Data is a collection of numbers (or symbols) with meaning. In other words: "10, 8, 5.5"" are numbers, but no data. "The city of Muenster, Germany had 282,210 registered inhabitants on Jan 1st, 2014"" is a statement containing data. You could argue that the "282,210"" is the data, the rest of the sentence giving the meaning, or that "city of Muenster, Germany", "282,210", "registered inhabitants", and "Jan 1, 2014" are all data elements of a single observation. One could go on and explain what exactly the city of Muenster, Germany is, what registration means, and how we should understand the phrase "Jan 1, 2014".

In practice, we can be pretty sloppy: 


```r
library(foreign)
d = read.dbf(system.file("shapes/sids.dbf", package="maptools")[1])
head(d)
```

```
##    AREA PERIMETER CNTY_ CNTY_ID        NAME  FIPS FIPSNO CRESS_ID BIR74
## 1 0.114     1.442  1825    1825        Ashe 37009  37009        5  1091
## 2 0.061     1.231  1827    1827   Alleghany 37005  37005        3   487
## 3 0.143     1.630  1828    1828       Surry 37171  37171       86  3188
## 4 0.070     2.968  1831    1831   Currituck 37053  37053       27   508
## 5 0.153     2.206  1832    1832 Northampton 37131  37131       66  1421
## 6 0.097     1.670  1833    1833    Hertford 37091  37091       46  1452
##   SID74 NWBIR74 BIR79 SID79 NWBIR79
## 1     1      10  1364     0      19
## 2     0      10   542     3      12
## 3     5     208  3616     6     260
## 4     1     123   830     2     145
## 5     9    1066  1606     3    1197
## 6     7     954  1838     5    1237
```

# Reference systems

In order to bind meaning to numbers of symbols (and make values valuable), we need _reference systems_. Reference systems define the context of values, and make them unambiguously interpretable, and by that _meaningful_. In [Stasch et al., 2014](http://www.sciencedirect.com/science/article/pii/S1364815213001977) we argue that for spatio-temporal information, we need at least four reference system basic types: space, time, qualities, and objects.

|symbol  |type |meaning|example|
|:--|:--|:--|:--|
|S|space   |$\RR^2$| $7^o$E, $52.2^o$N; WGS84 |
|T|time    |$\RR$| Jan 1, 2014, 12:00 UTC; ISO 8601; POSIX time  |
|Q|quality |$\RR$| $25.3^o$C ; UCUM; [SI](http://www.bipm.org/en/measurement-units) |
|D|object  |$\NN$| Edzer Pebesma, Passport NN3JR69F |

From the basic types, we use functions to create representations
of phenomena; these phenomena can be evaluated to generate data.

Functions are useful because

* they map from domain into range, and give one and only one range value for each domain value
* unlike data which is always discrete, function can represent _continuous phenomena_
* in much of the world around us, variation appears to be _continuously changing_ (over space, in time)

# Spatial data, spatio-temporal data

As mentioned above, data are always discrete. The reason for this is
that continuous variation in the real world is usually not understood
for 100%, and so cannot be captured fully by parametric, continuous
functions. Hence, we would need an infinite amount of observations
for any limited time frame or spatial extent to reprensent it.

## Limitation of relational databases

There is a tendency to store all data in (relational) databases. This is a good idea when the records refer to objects (such as persons), but is not always a good idea when the data refer to continuosly varying phenomena.  For instance, for images the elementary (discrete) observation is an image pixel. Yet, storing a pixel value in each record of a data base is not considered a good idea, because

* it takes much more space, and requires explicit storing of which pixel belongs to which image, and to which location (row/column)
* the natural ordering of pixels in a 2-D array gets lost
* the data base would need to take care of the fact that every pixel has one and only one value

## Phenomena types

### Continuously varying types

Fields: $S \times T \Rightarrow Q$; special cases: time series $T \Rightarrow Q$, e.g. for a particular sensor location; spatial fields $S \Rightarrow Q$, e.g. for a particular moment in time;

Examples: air temperature, CO2 content of the air, O2 pressure in the water

### Discrete objects or events

Point patterns: $D \Rightarrow S \times T$; special cases spatial ($D \Rightarrow S$) and temporal ($D \Rightarrow T$) point patterns.

Examples: epicenters of earth quakes; disease cases; land mines; sightings of a particular bird species.

Since both objects and events typically have a duration (or lifetime), their distinction is sometimes a matter of perspective. When considering a person as an object from the "now" perspective, on a geologic time scale its life is a short-duration event.

### Moving object trajectories

Objects that move their position (or extent) over time create trajectories $T \Rightarrow S$.

### Aggregations

# Statistics 

## Descriptive statistics

* Stevens's measurement scales
* Measures of central tendency
* Measures of variation
* Describing a distribution

## Statistical inference

Name the appropriate technique to compare

* a sample with a fixed value
* two random samples wrt their mean value
* two random samples wrt their variance
* $k$ random samples wrt their mean value
* the variation of two continuous variable
* how one continuous variable depends on more than one (continuous, or nominal) variables

# Spatial statistics, geostatistics

Spatial statistics concerns the analysis (description, modelling,
prediction, simulation) of spatial phenomena, where the spatial
locations play an explicit role. Spatial statistical techniques
usually focus on one of

* continuous phenomena (fields): geostatistics
* discrete objects (point patterns): point pattern analysis
* aggregations (areal data): areal data analysis

although sometimes several data types need to be integrated.

# R

[R](http://www.r-project.org/) is an open source environment for statistical computing and graphics that runs on windows, Mac, and unix (linux) computers. It is probably the most used software for data analysis in research, teaching, and industry. R is known for its massive amount of user-contributed extension packages which offer functionality in all kind of data analysis domains (spatial, finance, bioinformatics, HPC, graphical, web services, etc).

In essence, R implements a programming language that lets you execute (evaluate) expressions like

```r
a <- 1:4 # assign the numbers 1 through 4 to a; asignment doesn't print anything
a # simply print/echo
```

```
## [1] 1 2 3 4
```

```r
a + 1 # add one, print
```

```
## [1] 2 3 4 5
```

```r
a ^ 2 # square, print
```

```
## [1]  1  4  9 16
```

## R packages

## CRAN

The comprehensive R archive network ([CRAN](https://cran.r-project.org/)) is large a network of mirrors that serves besides the R software a set of (currently over 7000) quality controlled R extension packages. Having packages on CRAN makes it easy for R users:

* to install, and update extension packages, along with the packages on which they depend

and for R package developers to

* develop packages that depend on other quality-controlled (CRAN) packages
* distribute their extension package to the widest range of users
* distribute source code, and not have to worry about cross compilation on Windows or MacOS computers
* get informed about software issues due to changes in R, or in other packages

CRAN task views (reached from a CRAN mirror) give human-readable overviews of available CRAN packages, ordered by topic.

CRAN quality control includes

* checking against R development versions
* checking completeness of documentation
* running examples and (regression) tests
* checking packages dependencies

# Open source software

Open source software is software that you not only can use, but from which you can also read the source code. Open source software is not always for free: you can buy Ubuntu or Redhat linux distributions. The benefit of doing so lies often in service contracts. Data centers and cloud providers often offer paid services, but are built on open source software.

For scientific computing, using open source software is the only way to guarantee maximal transparency; along with open access to publications and data, it is one of the pilars of _open science_. 

Open source software is sometimes said to be better software, because many eyes make bugs shallow. A number of serious security flaws in abundant open source components (Heartbleed: ssh, Shellshock: bash) have stressed once more that for many eyes to look at (open sourc) software, effort (i.e.: money) is needed.

## Collaborative development: git, GitHub

Today it is extremely easy to publish open source software on the internet, and to contribute to, or collaborate with other developers in an open way. Currently the dominant platform for doing this is github. Other platforms have been popular in the past (sourceforge, google code), and there is no guarantee that github will remain popular, available, or even free.

Exercise: create a github account and create an open source project on it.

## Inviting third parties to collaborate

Having a project on github (or any other collaborative software development platform) is all but a guarantee that someone will discover your software, use it, and contribute. For this to happen, you need to actively communicate your work, draw attention to it, and advertise. Connecting the project to existing, similar projects may help (think of the case of R packages). 

## Licenses

When you create something and distribute it, there are automatic copyrights. Depending on whether you did this in an employment contract (and depending on the details of the contract) copyright might be with the author, or with the employer.

Licenses communicate under which conditions third parties are allowed to use your work, e.g. whether they are allowed 

* to modify it
* to redistribute modified copies, or
* to include it in commercial products

or whether they are obliged to 

* give you credit when they do

Software licences are somewhat more complex than general licenses of creative work (such as creative commons), because you can do more complex things with software than e.g. with plain texts or photos, such as compiling and linking.

Exercise: read the text of the following licenses:

* GPL 3
* LGPL
* Affero-GPL
* Apache 2.0
* WTFL
* CC-BY
* CC-BY-SA
* CC-BY-NC-ND

and discuss which one(s) are open (look also for definitions of open), which ones are copyleft, and which one you would be comfortable working with.
