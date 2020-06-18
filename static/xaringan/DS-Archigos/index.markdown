---
title: "Visualising Leaders"
subtitle: "A Grammar for Graphics"
author: "Robert W. Walker"
institute: "Atkinson Graduate School of Management"
date: "2019/04/15 (updated: 2019-04-20)"
output:
  xaringan::moon_reader:
    css: [default, rladies, rladies-fonts, animate.css]
    seal: false
    lib_dir: libs
    nature:
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
---
class: inverse
background-image: url("img/PicAnim.gif")

# Leaders and Grammar for Graphics



---

# A Grammar of Graphics

--
- data

--
- a mapping from data to aesthetics

--
- a geometry for representing the aesthetic


---
class: inverse

# My Primitive: A canvas

--
### Data as coordinates in 1 or 2-d with aesthetics and geometries

--
Graphics are generically flat; they are (at most) **two dimensional**.

That is caused by the screen.

--

**Our visuals must respect these limitations but we can add colors, shapes, and sizes,**
--
 or even emojis.  🔥

![](https://media.giphy.com/media/10pQQtsBUKz0Nq/giphy.gif)

---
class:inverse, center, middle, bounceIn, bounceOut

# The canvas

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-1-1.svg" width="672" style="display: block; margin: auto;" />


---
class: inverse, tada
# One Important Caveat

There is one notable and widely seen exception to this charaterization.  
Size is total tenure.<sup>1<sup>



.footnote[
[1] An install script for all the packages used is in the talk directory as /home/rob/Desktop/RWW8/academic-mymodPackagesUsed.R.  The interested reader can source /home/rob/Desktop/RWW8/academic-mymodXSCSetup.R.
]

---
class: inverse,heartBeat

## The Illustration

What determines x and y?    **Nothing.**    
Coordinates are arbitrary.

![](img/WordCloudLeaders.jpeg)




---
class: inverse, center, middle

# A Simple Example to Cement our Thinking

--

[Where am I?](https://where-am-i.net)


---
# I am in Oregon
## Let's Start There

Get the map of Oregon and then use `ggmap` to map it.


```r
OR_map <- get_map(getbb("Oregon"))
# ggmap(OR_map) 
```


---
class: inverse, wobble

## The Result

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-4-1.png" width="768" />


---
class: inverse

# Me as Data

For now, just my GPS coordinates.


```r
Me <- data.frame(lat=44.924943, lon=-123.043461)
```

![](https://media.giphy.com/media/tFV89pJJz3MoU/giphy.gif)

---
# Mapping Me...

- Put my data on the earlier map.  
- My data is a set of coordinates that are already defined on the map.  
- Let's locate me on the map.


```r
Me <- data.frame(lat=44.924943, lon=-123.043461)
ggmap(OR_map) +
geom_emoji(data=Me, aes(y=lat, x=lon), emoji="1f4aa", size=0.125) + theme_nothing()
```

---
class: inverse
# Me on the Map

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-7-1.png" width="768" />

---
class: inverse, heartBeat

# Data Visualisation on the Canvas
## Showcasing the Language of Visuals with Data on National Leaders


---
# The Data
# Archigos: A Database of National Leaders

Chiozza, Gleditsch, and Goemans have collected and maintained an encyclopedia of world leaders since the 1870s.

--
- Leader spells are units

--
- Nested in countries

--
- Entry and exit including types

--
- Real date formats 😿

```r
Archigos <- read_dta(url("http://www.rochester.edu/college/faculty/hgoemans/Archigos_4.1_stata14.dta"))
Archigos <- Archigos %>% mutate(leader = utf8_encode(leader))
kable(Archigos) %>%
  kable_styling() %>%
  scroll_box(width = "800px", height = "400px")
```


.footnote[
[1] Archigos [on the web](http://www.ksgleditsch.com/archigos.html).
]


---
## A Look

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:800px; "><table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> obsid </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> leadid </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> ccode </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> idacr </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> leader </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> startdate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> eindate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> enddate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> eoutdate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> entry </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> exit </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> exitcode </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> prevtimesinoffice </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> posttenurefate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> yrborn </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> yrdied </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> borndate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> ebirthdate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> deathdate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> edeathdate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> dbpediauri </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> numentry </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> numexit </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> numexitcode </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> numposttenurefate </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> fties </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> ftcur </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> USA-1869 </td>
   <td style="text-align:left;"> 81dcc176-1e42-11e4-b4cd-db5882bf8def </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> Grant </td>
   <td style="text-align:left;"> 1869-03-04 </td>
   <td style="text-align:left;"> 1869-03-04 </td>
   <td style="text-align:left;"> 1877-03-04 </td>
   <td style="text-align:left;"> 1877-03-04 </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> OK </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 1822 </td>
   <td style="text-align:right;"> 1885 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1885-07-23 </td>
   <td style="text-align:left;"> 1885-07-23 </td>
   <td style="text-align:left;"> https://urldefense.proofpoint.com/v2/url?u=http-3A__dbpedia.org_resource_Ulysses-5FS.-5FGrant&amp;d=BQID-g&amp;c=kbmfwr1Yojg42sGEpaQh5ofMHBeTl9EI2eaqQZhHbOU&amp;r=ZliGVSRwfirWoETOrKCh2RSnoygzVPWEk95Me9L-Kwo&amp;m=EaKyFx9mpkhPdFxsxzvW_fiM3jbYwM3xYLjVbSFoDAg&amp;s=x7yRI4mbwG8b0j8c_AwqAahtkPcCfIY2uH8tdRaReBw&amp;e= </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USA-1877 </td>
   <td style="text-align:left;"> 81dcc177-1e42-11e4-b4cd-db5882bf8def </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> Hayes </td>
   <td style="text-align:left;"> 1877-03-04 </td>
   <td style="text-align:left;"> 1877-03-04 </td>
   <td style="text-align:left;"> 1881-03-04 </td>
   <td style="text-align:left;"> 1881-03-04 </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> OK </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 1822 </td>
   <td style="text-align:right;"> 1893 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1893-01-17 </td>
   <td style="text-align:left;"> 1893-01-17 </td>
   <td style="text-align:left;"> https://urldefense.proofpoint.com/v2/url?u=http-3A__dbpedia.org_resource_Rutherford-5FB.-5FHayes&amp;d=BQID-g&amp;c=kbmfwr1Yojg42sGEpaQh5ofMHBeTl9EI2eaqQZhHbOU&amp;r=ZliGVSRwfirWoETOrKCh2RSnoygzVPWEk95Me9L-Kwo&amp;m=EaKyFx9mpkhPdFxsxzvW_fiM3jbYwM3xYLjVbSFoDAg&amp;s=8oshcxB52W-Pg-2a6AvRVJEYMU-S-RG55-369eJ-PyY&amp;e= </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USA-1881-1 </td>
   <td style="text-align:left;"> 81dcf24a-1e42-11e4-b4cd-db5882bf8def </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> Garfield </td>
   <td style="text-align:left;"> 1881-03-04 </td>
   <td style="text-align:left;"> 1881-03-04 </td>
   <td style="text-align:left;"> 1881-09-19 </td>
   <td style="text-align:left;"> 1881-09-19 </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Irregular </td>
   <td style="text-align:left;"> Assassination by Unsupported Individual </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Death </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 1831 </td>
   <td style="text-align:right;"> 1881 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1881-09-19 </td>
   <td style="text-align:left;"> 1881-09-19 </td>
   <td style="text-align:left;"> https://urldefense.proofpoint.com/v2/url?u=http-3A__dbpedia.org_resource_James-5FA.-5FGarfield&amp;d=BQID-g&amp;c=kbmfwr1Yojg42sGEpaQh5ofMHBeTl9EI2eaqQZhHbOU&amp;r=ZliGVSRwfirWoETOrKCh2RSnoygzVPWEk95Me9L-Kwo&amp;m=EaKyFx9mpkhPdFxsxzvW_fiM3jbYwM3xYLjVbSFoDAg&amp;s=qTPSlRS-mPD_m8ZM3luuJ4W47DtmOPoXSnSZn-lYsqM&amp;e= </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USA-1881-2 </td>
   <td style="text-align:left;"> 81dcf24b-1e42-11e4-b4cd-db5882bf8def </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> Arthur </td>
   <td style="text-align:left;"> 1881-09-19 </td>
   <td style="text-align:left;"> 1881-09-19 </td>
   <td style="text-align:left;"> 1885-03-04 </td>
   <td style="text-align:left;"> 1885-03-04 </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> OK </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 1829 </td>
   <td style="text-align:right;"> 1886 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1886-11-18 </td>
   <td style="text-align:left;"> 1886-11-18 </td>
   <td style="text-align:left;"> https://urldefense.proofpoint.com/v2/url?u=http-3A__dbpedia.org_resource_Chester-5FA.-5FArthur&amp;d=BQID-g&amp;c=kbmfwr1Yojg42sGEpaQh5ofMHBeTl9EI2eaqQZhHbOU&amp;r=ZliGVSRwfirWoETOrKCh2RSnoygzVPWEk95Me9L-Kwo&amp;m=EaKyFx9mpkhPdFxsxzvW_fiM3jbYwM3xYLjVbSFoDAg&amp;s=XiglK4IJ3ZCC1kR4Hmb8eVB-V7A0tQprCtTKzOl42YM&amp;e= </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USA-1885 </td>
   <td style="text-align:left;"> 34fb1558-3bbd-11e5-afeb-eb6f07f9fec7 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> Cleveland </td>
   <td style="text-align:left;"> 1885-03-04 </td>
   <td style="text-align:left;"> 1885-03-04 </td>
   <td style="text-align:left;"> 1889-03-04 </td>
   <td style="text-align:left;"> 1889-03-04 </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> OK </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 1837 </td>
   <td style="text-align:right;"> 1908 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1908-06-24 </td>
   <td style="text-align:left;"> 1908-06-24 </td>
   <td style="text-align:left;"> https://urldefense.proofpoint.com/v2/url?u=http-3A__dbpedia.org_resource_Grover-5FCleveland&amp;d=BQID-g&amp;c=kbmfwr1Yojg42sGEpaQh5ofMHBeTl9EI2eaqQZhHbOU&amp;r=ZliGVSRwfirWoETOrKCh2RSnoygzVPWEk95Me9L-Kwo&amp;m=EaKyFx9mpkhPdFxsxzvW_fiM3jbYwM3xYLjVbSFoDAg&amp;s=BH6RahZV58hS1fIGz1muHnQkbAirSz4Yy2wc6chejsQ&amp;e= </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USA-1889 </td>
   <td style="text-align:left;"> 81dcf24d-1e42-11e4-b4cd-db5882bf8def </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> Harrison </td>
   <td style="text-align:left;"> 1889-03-04 </td>
   <td style="text-align:left;"> 1889-03-04 </td>
   <td style="text-align:left;"> 1893-03-04 </td>
   <td style="text-align:left;"> 1893-03-04 </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:left;"> Regular </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> OK </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 1833 </td>
   <td style="text-align:right;"> 1901 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 1901-03-13 </td>
   <td style="text-align:left;"> 1901-03-13 </td>
   <td style="text-align:left;"> https://urldefense.proofpoint.com/v2/url?u=http-3A__dbpedia.org_resource_Benjamin-5FHarrison&amp;d=BQID-g&amp;c=kbmfwr1Yojg42sGEpaQh5ofMHBeTl9EI2eaqQZhHbOU&amp;r=ZliGVSRwfirWoETOrKCh2RSnoygzVPWEk95Me9L-Kwo&amp;m=EaKyFx9mpkhPdFxsxzvW_fiM3jbYwM3xYLjVbSFoDAg&amp;s=MA-TUrYNLJuZ9PTyDnsCkyBUtUyUkXWBHX7_p3f3pnA&amp;e= </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table></div>


---
class: inverse, bottom,  bounceIn
background-image: url("img/WordCloudLeaders.jpeg")
background-size: 500px
background-position: 80% 8%


# One discrete variable: 
## Frequency [Barplot] or Probability [Mosaic]


--


```r
Archigos %>% ggplot(., aes(x=leader)) + 
  geom_bar(fill="#88398A") + 
  labs(x="Leader", y="Frequency", 
       title="The Frequency of Leaders", 
       subtitle = "Leaders had as many as six tenures")
```


---
class: inverse

## too many values of x make bad graphics


<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-11-1.png" width="672" />



---
class: inverse, hinge

## Show More than Three Spells



```r
Archigos %>% group_by(leader) %>% mutate(count = n()) %>% filter(count > 3) %>% ggplot(., aes(x=leader)) + geom_bar(fill="#88398A") + labs(x="Leader", y="Leadership Spells", title="The Frequency of Leaders", subtitle = "Leaders with more than three tenures") + coord_flip()
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-12-1.png" width="672" />


---
class: inverse

# A Small Number of Categories Works Best

--

## How did leaders enter?


```r
Archigos %>% ggplot(., aes(x=entry)) + geom_bar(fill="#88398A") + labs(title="How did the Leader Enter?", y="Count of Leaders", x="") + coord_flip() + theme_economist_white()
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-13-1.png" width="576" />

---
class: inverse

# A Small Number of Categories Works Best

--

## How did leaders enter? [Probability]


```r
Archigos %>% ggplot(.) + geom_mosaic(aes(x=product(entry), fill=entry)) + labs(title="How did the Leader Enter?", y="", x="", fill="Method of Entry")  + coord_flip()
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-14-1.png" width="576" />



---
class: inverse, center, middle, bounceOut

# One quantitative variable: Leadership tenure
## How long do leaders stay in office?

---
class: right
background-image: url("img/TenureBack.svg")
background-size: contain

# Visualising Tenure: One numeric variable


## choose a scale 
--

### connect points, create polygons, plot statistics




---
class: inverse

# One numeric variable:  
### Visualising Tenure


```r
Archigos <- Archigos %>% mutate(tenureY = year(enddate) - year(startdate))
plt1 <- Archigos %>% ggplot(., aes(tenureY)) + 
  {{ geom_area(stat="bin", bins=30, fill="#88398A") }} + labs(x="Tenure (in years)", y="Frequency", title="geom_area") + theme_economist_white()
plt2 <- Archigos %>% ggplot(., aes(tenureY))  +  
  {{ geom_density(, fill="#88398A") }} + labs(x="Tenure (in years)", y="Frequency", title="geom_density") + theme_economist_white()
plt3 <- Archigos %>% ggplot(., aes(tenureY)) + 
  {{ geom_histogram(, fill="#88398A") }} + labs(x="Tenure (in years)", y="Frequency", title="geom_histogram") + theme_economist_white()
plt4 <- Archigos %>% ggplot(., aes(tenureY)) +  
  {{ geom_dotplot(, fill="#88398A") }} + labs(x="Tenure (in years)", y="Frequency", title="geom_dotplot") + theme_economist_white()
grid.arrange(plt1,plt2,plt3,plt4)
```

---
class: inverse, rubberBand, center, middle

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-17-1.png" width="768" />



---
class: inverse, zoomInDown

## Using the Percentiles Leads to a Boxplot


```r
Archigos %>%  ggplot(., aes(y=tenureY)) +
  geom_boxplot(fill="#88398A") + labs(x="Tenure (in years)", y="Frequency", title="geom_boxplot") + theme_economist_white()
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-18-1.png" width="768" />


---
class: inverse, flash, middle, center

# Two Discrete Variables: 
## A Table

---

# How do leaders enter and exit?


```r
Archigos %>% tabyl(exit,entry)
```

```
##                       exit Foreign Imposition Irregular Regular Unknown
##                    Foreign                  8        22      42       0
##                  Irregular                  5       255     340       0
##              Natural Death                  5        40     157       0
##                    Regular                 21       236    2036       0
##  Retired Due to Ill Health                  0         5      63       0
##            Still in Office                  0        12     156       0
##                    Suicide                  0         1       2       0
##                    Unknown                  1         0       0       2
```

```r
Archigos %>% tabyl(exit,entry) %>% adorn_percentages("col") %>% adorn_pct_formatting()
```

```
##                       exit Foreign Imposition Irregular Regular Unknown
##                    Foreign              20.0%      3.9%    1.5%    0.0%
##                  Irregular              12.5%     44.7%   12.2%    0.0%
##              Natural Death              12.5%      7.0%    5.6%    0.0%
##                    Regular              52.5%     41.3%   72.8%    0.0%
##  Retired Due to Ill Health               0.0%      0.9%    2.3%    0.0%
##            Still in Office               0.0%      2.1%    5.6%    0.0%
##                    Suicide               0.0%      0.2%    0.1%    0.0%
##                    Unknown               2.5%      0.0%    0.0%  100.0%
```

---
class:inverse

# Visualizing Two Categorical Variables

--

The Table is more informative because the *geometry* obscures information.


```r
Archigos %>% ggplot(., aes(x=entry,y=exit)) + geom_count(color="purple") + labs(x="How did the Leader Enter?", y="How did the Leader Exit?", title="Leader Entry and Exit by Spell") + theme_economist()
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-20-1.png" width="576" />

---
class: inverse

## Geometries allow area (like maps) on a unit square

It is usually suggested to avoid pie charts because squares are hard enough.


```r
library(ggmosaic)
ggplot(data=Archigos) + 
  geom_mosaic(aes(x = product(exit,entry), fill=exit)) + 
  labs(y="Method of Exit", x="Method of Entry", main="Entry and Exit by Leaders") + 
  theme_minimal() + guides(fill=guide_legend(title="Method of Exit")) +
  theme(axis.text.y =  element_text(size=8, hjust=0.25), axis.text.x =  element_text(size=8, angle=45, vjust=1), 
                          legend.text = element_text(size=10))
```



---
class: inverse, heartBeat


<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-22-1.png" width="960" />


---
class: inverse, middle, center

# One Discrete and one Quantitative Variable

--
## How does Tenure vary by Method of Entry?

---
# The canvas

- x is method of entry
- y is tenure in years

---
class:inverse

# The geometry is everything
### Jitters

Let me show the points [jittered].

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-23-1.png" width="768" />

---
# The single quantitative distributions don't work equally well.

Five common types:
- `geom_col`  
- `geom_dotplot`  
- `geom_boxplot`  
- `geom_violin`
- `geom_ridges`

---
class: inverse 
## Common types: geom_col
--

### A grouped barplot
**It sums the y values over x**


```r
Archigos %>%  ggplot(., aes(entry, tenureY)) + 
  geom_col() + labs(y="Tenure (in years)", x="Method of Entry", title="geom_col")
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-24-1.png" width="576" />

---
class: inverse
## Common types: geom_dotplot
--

### A grouped dotplot

How big are the bins, on what axis, and stacked how?
They can run into each other


```r
Archigos %>%  ggplot(., aes(entry, tenureY)) + 
  geom_dotplot(binwidth=1/20, binaxis = "y", stackdir = "center") + labs(y="Tenure (in years)", x="Entry Method", title="geom_dotplot")
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-25-1.png" width="576" />


---
class: inverse
## Common types: geom_boxplot
--

### A grouped boxplot


```r
Archigos %>%  ggplot(., aes(entry, tenureY)) + 
  geom_boxplot() + labs(y="Tenure (in years)", x="Entry Method", title="geom_boxplot")
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-26-1.png" width="672" />


---
class: inverse
## Common types: geom_violin
--

### A grouped density projected in two dimensions


```r
Archigos %>%  ggplot(., aes(entry, tenureY)) + 
  geom_violin() + labs(y="Tenure (in years)", x="Entry Method", title="geom_violin")
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-27-1.png" width="672" />

---
class: inverse, bounceIn 
## Common types: geom_ridgeline

--
### A grouped density projected in two dimensions (flip x and y)



```r
Archigos %>% ggplot(., aes(x=tenureY, y=entry, fill=factor(..quantile..))) +
  stat_density_ridges(geom = "density_ridges_gradient", calc_ecdf = TRUE, quantiles = 4, quantile_lines = TRUE,  scale = 1) + scale_fill_viridis(discrete = TRUE, name = "Quartiles") + labs(x="Tenure (in years)", y="Entry Method", title="geom_ridges")
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-28-1.png" width="672" />

---
class: inverse, center, middle

# Two Quantative Variables:
--

## Tenure and the Year Spells End

---
background-image: url("img/Canvas.svg")
background-size: contain

# My canvas has been arbitrarily rendered.

--

Now map the data to the canvas. 
- Replace x axis with Years Spells End 
- Replace y axis with Tenure 



---
class:
background-image: url("img/Canvas-2.svg")
background-size: contain

# My canvas has coordinates.

--

Geometries are:<sup>1<sup> 

- polygons [Oregon?]
- **points** 
- connectors [lines, smooths] 


.footnote[
[1] The root cause is pixels.
]

---
class: inverse, swing
background-image: url("img/Canvas-2.svg")
background-size: contain

# Adding information with layers

.pull-left[
Layers
- alpha
- color and/or fill
- shape or label
- size 
]

--

.pull-right[
![](https://media.giphy.com/media/sdJxf28nKqfvi/giphy.gif)

]

---
class: inverse, flash

# Tenure by Year Spells End

It's messy.  In many ways, that's perfect.
- geom_point() makes it worse, they're stacked

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-29-1.png" width="864" />

---
class: inverse
background-image: url("img/ScatterLayer.svg")
background-size: contain

# Tenure by Year Spells End

This is better but still messy.
- Jitter points around a bit with geom_jitter()


```r
Archigos %>% ggplot(aes(x=endYear, y=tenureY)) + 
  geom_jitter()  +  #<<
  theme_dark() + labs(x="Year Leader's Spell Ended", y="Tenure of Leader (not cumulative)")
```

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-30-1.png" width="576" />



---
class: inverse
background-image: url("img/JitterLayer.svg")
background-size: contain

# Layers

--

.pull-left[

Color aesthetics:
- **alpha** 
- alpha controls transparency
- concentration can be seen


```r
Archigos %>% ggplot(aes(x=endYear, y=tenureY)) + 
  geom_jitter(alpha=0.1) +  #<<
  theme_economist_white() + theme(legend.text = element_text(size=8)) + labs(x="Year Leader's Spell Ended", y="Tenure of Leader (not cumulative)", color="Method of Entry")
```


]

.pull-right[

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-32-1.png" width="672" />

]




---
class: inverse
background-image: url("img/BGGraph-alpha.svg")
background-size: contain

# Layers

--

.pull-left[

Color aesthetics:
- **color and/or fill** 
- Color colors the shape outline
- Fill fills the shape interior


```r
Archigos %>% 
ggplot(., aes(x=endYear, y=tenureY, color=entry))  + #<<
  geom_jitter(alpha=0.3)  +  
  scale_color_viridis_d() + theme(legend.text = element_text(size=8)) + labs(x="Year Leader's Spell Ended", y="Tenure of Leader (not cumulative)", color="Method of Entry")
```


]

.pull-right[

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-34-1.png" width="480" />

]


---
class: 
background-image: url("img/JitterC.svg")
background-size: contain

--

# Layers


.pull-left[

- **shape** 


```r
Archigos %>% ggplot(., aes(x=endYear, y=tenureY, color=entry,
shape=gender)) +  #<<
geom_jitter(alpha=0.3) + 
  scale_fill_viridis_d()  + theme(legend.text = element_text(size=8)) + labs(x="Year Leader's Spell Ended", y="Tenure of Leader (not cumulative)", color="Method of Entry", shape="Gender")
```


]

.pull-right[

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-36-1.png" width="672" />

]

---
background-image: url("img/LayerMF.svg")
background-size: contain

--
# Layers


.pull-left[

**label** comes in two forms
- geom_text() for text
- geom_label for a text box<sup>1<sup> 



```r
Archigos %>% ggplot(., aes(x=endYear, y=tenureY, color=entry, label=gender)) + 
geom_label(alpha=0.2) + theme_economist_white() + theme(legend.text = element_text(size=7)) + labs(x="Year Leader's Spell Ended", y="Tenure of Leader (not cumulative)", color="Method of Entry", shape="Gender", title="Gender, Method of Entry, Tenure, and Year Spell Ends") 
```


]

.pull-right[

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-38-1.png" width="672" />

]

.footnote[
[1] The excellent `ggrepel` package works with spatial tools to assist the management of placement and collisions of text.
]


---

## Layers

What determines x and y?    **Nothing.**    
Coordinates are arbitrary.
Frequency determines the size.

![](img/WordCloudLeaders.jpeg)


---

# We can do that.

Size is the number of previous times in office.

<img src="/talk/GGSC/index_files/figure-html/unnamed-chunk-39-1.png" width="864" />

---
class: inverse

# A Grammar of Graphics

- data
- a mapping from data to aesthetics
- a geometry for representing the aesthetic

We deployed shapes, colors, text, size, color, fill, and alpha with one or two coordinates to create a fairly extensive set of visualisations of leaders.

We also succeeded in displaying five distinct bits of data in one flat design.

---
# Adding Further Information Requires Time

A terrible pun.

![](img/ORSCMap.gif)

---
class: inverse
# That's Timely


![](img/DrawLeaderEnds.gif)


---
class: bottom
background-image: url("img/PicAnim.gif")
background-position: 65% 8%


# Thanks!

Slides created via the R package [**xaringan**](https://github.com/yihui/xaringan).

Theme borrowed from `@apreshill` and her `r-ladies` theme.

