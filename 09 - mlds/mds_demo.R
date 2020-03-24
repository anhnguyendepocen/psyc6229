# mds_demo.R

rm( list=ls() )

# to illustrate multidimensional scaling we'll use the R function cmdscale(),
# whose name is a contraction of "classical multidimensional scaling"
?cmdscale

# we'll also use the built-in variables UScitiesD and eurodist, which report
# the distances between pairs of cities
dist <- UScitiesD   # straight-line distances
# dist <- eurodist    # road distances

# apply classical MDS to the distance dataset
mds <- cmdscale( dist )

# make a plot with no points ('n'), then label the ticks with city names
plot( mds, type='n' )
text( mds[, 1], mds[, 2], labels(dist) )

# the result is a map of where the distances between cities are correct,
# but the map may be rotated and/or mirrored, since there is no information in the
# distance dataset that conveys, for example, which city is to the north of other
# cities.  in the map of US cities, the map is flipped left-to-right and also
# top-to-bottom.  our goal, though, was to find a representation that encodes
# the distances between cities, and cmdscale() has accomplished that with a 2D map.
# some datasets would only need a 1D map, and others would require a 3D or n-D map.
