# trajanimate
animate trajectory files

Thus far a function to take x y coordinates and produce an animated map as seen on:  https://jevansbio.wordpress.com/2018/05/06/google-timelines-r-and-animating-ltraj/

Usage in R with animate package

```R
saveGIF({
  animatetraj(traj2[[1]],8)
}, interval = 0.1, ani.width = 200, ani.height = 200)
