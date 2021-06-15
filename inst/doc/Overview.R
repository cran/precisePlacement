## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  )

knitr::opts_chunk$set(dev.args = list(png = list(type = "cairo")))


## ----echo = TRUE, fig.height = 5, fig.width = 5-------------------------------
library(precisePlacement)

par(xpd = NA, oma = 1:4)

plot(1:10, pch = 19)

highlightDeviceRegion()
highlightFigureRegion()
highlightPlotRegion()
highlightDataRegion()

showMarginLines()
showOuterMarginLines()

legend('topleft', c('Data Region', 'Plot Region', 'Figure Region', 'Device Region'),
       text.col = c('darkgreen', 'red', 'orange', 'skyblue'), bty = 'n', text.font = 2,
       xjust = 0.5, yjust = 0.5)


## ---- echo = TRUE, fig.height = 3, fig.width = 3------------------------------
plot(1:10)

getLinesPerInch()
getInchesPerLine()
getDataPerLine()
getLinesPerDatum()
getDataPerInch()
getInchesPerDatum()
getPixelsPerInch()
getInchesPerPixel()
getPixelsPerLine()
getLinesPerPixel()
getPixelsPerDatum()
getDataPerPixel()


## ---- echo = TRUE, fig.height = 5, fig.width = 5------------------------------
plot(seq(as.Date('2018-01-01'), as.Date('2019-01-01'), length.out = 10), 1:10,
     pch = 19, xlab = '', ylab = '')

## Identify the center of the plot.
abline(h = convertUnits('proportion', 0.5, 'data', axis = 'y'),
       col = 'red', lwd = 4)
abline(v = convertUnits('proportion', 0.5, 'data', axis = 'x'),
       col = 'blue', lwd = 4)

## Change the region we are defining the proportions from.
abline(v = convertUnits('proportion', 0.75, 'data', axis = 'x', region = 'plot'),
       col = 'darkgreen', lwd = 4)
abline(v = convertUnits('proportion', 0.75, 'data', axis = 'x', region = 'device'),
       col = 'orange', lwd = 4)



## ---- echo = TRUE, fig.height = 5, fig.width = 5------------------------------
par(xpd = NA, oma = c(0, 0, 0, 5))
plot(1:10, pch = 19)

legend(x = 11,
       y = convertUnits('proportion', 0.5, 'data', axis = 'y', region = 'device'),
       LETTERS[1:8], ncol = 1, bty = 'n', text.font = 2, text.col = 1:8,
       xjust = 0.5, yjust = 0.5, cex = 3
       )


## ---- echo = TRUE, fig.height = 5, fig.width = 5------------------------------
projects <- list(A = as.Date(c('2018-01-01', '2018-06-04')),
                 B = as.Date(c('2018-02-01', '2018-11-01')),
                 C = as.Date(c('2018-11-01', '2018-12-01')),
                 D = as.Date(c('2018-03-01', '2018-05-01')),
                 E = as.Date(c('2018-01-01', '2018-03-01')),
                 F = as.Date(c('2018-09-01', '2018-12-01')),
                 G = as.Date(c('2018-05-01', '2018-07-01'))
                 )

x <- seq(as.Date('2018-01-01'), as.Date('2019-01-01'), length.out = length(projects))
y <- 1:length(projects)

plot(x, y, xlim = range(x), ylim = c(0.5, length(projects) + 0.5),
     type = 'n', xlab = 'Date', ylab = '', axes = FALSE, xaxs = 'i', yaxs = 'i')

axis(1, pretty(x), pretty(x))
axis(2, at = y, labels = names(projects), las = 2)
box()

lineWidth <- (getRange('plot', 'data')[2] / length(projects)) * getPixelsPerDatum()[2]

for (ii in seq_along(projects))
    lines(projects[[ii]], rep(ii, 2), lwd = lineWidth, ljoin = 2, lend = 1)


## ---- echo = TRUE, fig.height = 7, fig.width = 7------------------------------
plot(1:10, pch = 19)

originalPar <- par()

## Select a region in terms of proportions of the existing one.
omi <- omiForSubFigure(0.5, 0.05, 0.95, 0.5, region = 'device')
par(omi = omi, new = TRUE, xpd = NA)
plot(1:10, pch = 19, col = 'red')
highlightFigureRegion()

## Reset to the original par otherwise we will be referencing the subplot.
originalPar[c('cin', 'cra', 'csi', 'cxy', 'din', 'page')] <- NULL
par(originalPar)

## Select a new region in terms of the original plotting units.
omi <- omiForSubFigure(2, 6, 5, 10, units = 'data')
par(omi = omi, mar = c(0, 0, 0, 0))
plot(1:10, pch = 19, col = 'red', xlab = '', ylab = '')
highlightFigureRegion()


## ---- echo = FALSE, fig.height = 7, fig.width = 7-----------------------------
par(xpd = NA)

oldPar <- par(mfrow = c(2, 2), oma = c(1.1,2.1,3.5,4.5))

##******

plot(1:10, pch = 19)

highlightDeviceRegion()
highlightFigureRegion()
highlightPlotRegion()
highlightDataRegion()

showMarginLines()

##******

par(mar = c(5,5,5,5))

plot(1:10, pch = 19)

highlightDeviceRegion()
highlightFigureRegion()
highlightPlotRegion()
highlightDataRegion()

showMarginLines()

##******

par(mar = c(2,2,2,2))

plot(1:10, pch = 19)

highlightDeviceRegion()
highlightFigureRegion()
highlightPlotRegion()
highlightDataRegion()

showMarginLines()

legend('topleft',
       c('Data Region', 'Plot Region', 'Figure Region', 'Device Region'),
       text.col = c('darkgreen', 'red', 'orange', 'skyblue'), bty = 'n', text.font = 2,
       cex = 0.8, xjust = 0.5, yjust = 0.5)

##******

par(mar = c(2,5,2,2))

plot(1:10, pch = 19)

highlightDeviceRegion()
highlightFigureRegion()
highlightPlotRegion()
highlightDataRegion()

showMarginLines()

##******

showOuterMarginLines()

cat("par('mfg'): ", par('mfg'), '\n')
cat('Boundaries of data region:', getBoundaries('data'), '\n')
cat('Boundaries of plot region:', getBoundaries('plot'), '\n')
cat('Boundaries of figure region:', getBoundaries('figure'), '\n')
cat('Boundaries of device region:', getBoundaries('device'), '\n')


## ---- echo = TRUE, fig.height = 7, fig.width = 7------------------------------
par(xpd = NA, mfrow = c(2, 2))

plot(1:10, pch = 19)
plot(1:10, pch = 19)
plot(1:10, pch = 19)
plot(1:10, pch = 19)

print(getBoundaries('device', units = 'data'))
print(getBoundaries('device', units = 'lines'))

x <- getBoundaries('device', units = 'lines')
## lineLocations is a shortcut to using convertUnits.
abline(h = lineLocations(side = 1, 0:x[1]), col = 'red', lty = 2)
abline(v = lineLocations(side = 2, 0:x[2]), col = 'blue', lty = 2)
abline(h = lineLocations(side = 3, 0:x[3]), col = 'green', lty = 2)
abline(v = lineLocations(side = 4, 0:x[4]), col = 'black', lty = 2)


