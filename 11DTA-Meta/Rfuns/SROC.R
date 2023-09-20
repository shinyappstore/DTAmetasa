
plot.srocsa <- function(
  x,  
  sroc.type = c("sroc", "hsroc"),
  sroc.cols = gray.colors(ncol(as.matrix(x@par)), gamma = 1, start = 0, end = 0.5),
  sroc.lty = 1,
  sroc.lwd = 1,
  add.spoint = TRUE,
  sp.pch = 19,
  sp.cex = 1,
  plot.ci = FALSE,
  sroc.ci.col = "red",
  sroc.ci.lty = 2,
  sroc.ci.lwd = 1,
  ci.level = 0.95,
  xlab = "FPR",
  ylab = "TPR",
  addon = FALSE,
  ...
){
  if(inherits(x,"srocsa")){ par <- as.matrix(x@par)}
  else{
  stop("error")
  }
  
  if(nrow(par) < 5) stop("PLEASE CHECK THE INPUT MATRIX")

  sroc.type <- match.arg(sroc.type)

  if (!addon) plot(NULL, xlim=c(0,1), ylim=c(0,1), xlab = xlab, ylab = ylab, ...)

  for (i in 1:ncol(par)) {

    u1  <- par[1,i]
    u2  <- par[2,i]
    t1  <- par[3,i]
    t2  <- par[4,i]

    if(sroc.type =="sroc") r <- par[5, i] else r <- -1

    f <- function(x) plogis(u1 - (t1*t2*r/(t2^2)) * (qlogis(x) + u2))
    curve(f, 0, 1,
          col = sroc.cols[i],
          add = TRUE,
          lty = sroc.lty,
          lwd = sroc.lwd,
          ...)
  }

  if (add.spoint) {

    sens <- plogis(par[1,])
    spec <- plogis(par[2,])
    points(1-spec, sens, col=sroc.cols, pch = sp.pch, cex = sp.cex)

    }

  if(plot.ci & inherits(x,"tdsameta")){

    u1 <- par[1]
    u2 <- par[2]
    t1 <- par[3]
    t2 <- par[4]

    if(sroc.type=="sroc") r  <- par[5] else r <- -1


      f.lb <- function(x) plogis( u1 - (t1*t2*r/t2^2) * (qlogis(x) + u2) + qnorm((1-ci.level)/2, lower.tail = TRUE) * suppressWarnings(sqrt(.QIQ.sroc(x, u1, u2, t1, t2, r, x@var.matrix[[1]]))))

      f.ub <- function(x) plogis( u1 - (t1*t2*r/t2^2) * (qlogis(x) + u2) + qnorm((1-ci.level)/2, lower.tail = FALSE) * suppressWarnings(sqrt(.QIQ.sroc(x, u1, u2, t1, t2, r, x@var.matrix[[1]]))))

      curve(f.lb, add = TRUE, col = sroc.ci.col, lty = sroc.ci.lty, lwd = sroc.ci.lwd)

      curve(f.ub, add = TRUE, col = sroc.ci.col, lty = sroc.ci.lty, lwd = sroc.ci.lwd)

      }


}
SROC <- function(
  par,  
  sroc.type = c("sroc", "hsroc"),
  sroc.cols = gray.colors(ncol(as.matrix(par)), gamma = 1, start = 0, end = 0.5),
  sroc.lty = 1,
  sroc.lwd = 1,
  add.spoint = TRUE,
  sp.pch = 19,
  sp.cex = 1,
  plot.ci = FALSE,
  sroc.ci.col = "red",
  sroc.ci.lty = 2,
  sroc.ci.lwd = 1,
  ci.level = 0.95,
  xlab = "FPR",
  ylab = "TPR",
  addon = FALSE,
  ...
){

  if(inherits(par,"dtametasa")) par <- as.matrix(par$par[1:5]) else par <- as.matrix(par)
  
  if(nrow(par) < 5) stop("PLEASE CHECK THE INPUT MATRIX")
  
  # par <- as.matrix(par)

  sroc.type <- match.arg(sroc.type)

  if (!addon) plot(NULL, xlim=c(0,1), ylim=c(0,1), xlab = xlab, ylab = ylab, ...)

  for (i in 1:ncol(par)) {

    u1  <- par[1,i]
    u2  <- par[2,i]
    t1  <- par[3,i]
    t2  <- par[4,i]

    if(sroc.type =="sroc") r <- par[5, i] else r <- -1

    f <- function(x) plogis(u1 - (t1*t2*r/(t2^2)) * (qlogis(x) + u2))
    curve(f, 0, 1,
          col = sroc.cols[i],
          add = TRUE,
          lty = sroc.lty,
          lwd = sroc.lwd,
          ...)
  }

  if (add.spoint) {

    sens <- plogis(par[1,])
    spec <- plogis(par[2,])
    points(1-spec, sens, col=sroc.cols, pch = sp.pch, cex = sp.cex)

  }


  if(plot.ci & inherits(par,"dtametasa")){

    u1 <- par$par[1]
    u2 <- par$par[2]
    t1 <- par$par[3]
    t2 <- par$par[4]

    if(sroc.type=="sroc") r  <- par$par[5] else r <- -1


      f.lb <- function(x) plogis( u1 - (t1*t2*r/t2^2) * (qlogis(x) + u2) + qnorm((1-ci.level)/2, lower.tail = TRUE) * suppressWarnings(sqrt(.QIQ.sroc(x, u1, u2, t1, t2, r, par$var.ml[1:5,1:5]))))

      f.ub <- function(x) plogis( u1 - (t1*t2*r/t2^2) * (qlogis(x) + u2) + qnorm((1-ci.level)/2, lower.tail = FALSE) * suppressWarnings(sqrt(.QIQ.sroc(x, u1, u2, t1, t2, r, par$var.ml[1:5,1:5]))))

      curve(f.lb, add = TRUE, col = sroc.ci.col, lty = sroc.ci.lty, lwd = sroc.ci.lwd)

      curve(f.ub, add = TRUE, col = sroc.ci.col, lty = sroc.ci.lty, lwd = sroc.ci.lwd)

      }


}

