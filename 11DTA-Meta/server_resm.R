## DTA meta

## reitsma's model
# reitsma <- reactive(

#   reitsma(data(), 
#   correction.control = input$allsingle, 
#   level = input$ci.level, correction = 0.5, 
#   method=input$ci.method,
#   alphasens = input$alpha, alphafpr = input$alpha 
#   )

#   )

fit.reitsma <- reactive({
  reitsma(data(), 
  correction.control = input$allsingle, 
  level = input$ci.level, 
  correction = 0.5, 
  method=input$res.method
  )
})

output$reitsma <- renderPrint({
 fit <- fit.reitsma()
 fit$call <- NULL
 summary(fit)
  })

output$reitsma.dt <- renderDT({
  fit.reitsma <- fit.reitsma()
  fit.reitsma.sum <- summary(fit.reitsma)

  par <- c(
    fit.reitsma$coeff[1], -fit.reitsma$coeff[2], 
    sqrt(fit.reitsma$Psi[1,1]), sqrt(fit.reitsma$Psi[2,2]), 
    -fit.reitsma$Psi[1,2]/sqrt(fit.reitsma$Psi[1,1]*fit.reitsma$Psi[2,2]))
  
lgt.sens.num <- fit.reitsma.sum$coefficients[1,c(1,5,6)]
lgt.spec.num <- fit.reitsma.sum$coefficients[2,c(1,5,6)]
sens.num  <- fit.reitsma.sum$coefficients[3,c(1,5,6)]
spec.num  <- fit.reitsma.sum$coefficients[4,c(1,5,6)]

  lgt.sens.ci = sprintf("%.4f (%.4f, %.4f)", lgt.sens.num[1], lgt.sens.num[2], lgt.sens.num[3]) 
  lgt.spec.ci = sprintf("%.4f (%.4f, %.4f)", -lgt.spec.num[1], -lgt.spec.num[3], -lgt.spec.num[2]) 
  sens.ci = sprintf("%.4f (%.4f, %.4f)", sens.num[1], sens.num[2], sens.num[3] )
  spec.ci = sprintf("%.4f (%.4f, %.4f)", spec.num[1], spec.num[2], spec.num[3] ) 


  par.df <- data.frame(
    round(SAUC(par),4),
    sens.ci, spec.ci, lgt.sens.ci, lgt.spec.ci,
    round(sqrt(fit.reitsma$Psi[1,1]),4), round(sqrt(fit.reitsma$Psi[2,2]),4), 
    round(-fit.reitsma$Psi[1,2]/sqrt(fit.reitsma$Psi[1,1]*fit.reitsma$Psi[2,2]),4)
    )
  colnames(par.df) <- c( 
    "SAUC",
    "Sens (95%CI)", "Spec (95%CI)",
    "logit-Sens (95%CI)", "logit-Spec (95%CI)", 
    "tau1", "tau2", "rho")
  rownames(par.df) <- c("Estimates")
  return(par.df)
})


fit.glmm <- reactive({
  GLMMmodel(data())
})
output$glmm <- renderPrint({
  fit.glmm()
  })

output$glmm.dt <- renderDT({
  fit.glmm <- fit.glmm()

  lsens = fit.glmm$coeff[1,1]
  lspec = fit.glmm$coeff[2,1]
  se.lsens = fit.glmm$coeff[1,2] 
  se.lspec = fit.glmm$coeff[2,2]


lgt.sens.num = c(lsens, lsens-qnorm(0.975)*se.lsens, lsens+qnorm(0.975)*se.lsens) 
lgt.spec.num = c(lspec, lspec-qnorm(0.975)*se.lspec, lspec+qnorm(0.975)*se.lspec) 

  lgt.sens.ci = sprintf("%.4f (%.4f, %.4f)", lgt.sens.num[1], lgt.sens.num[2], lgt.sens.num[3]) 
  lgt.spec.ci = sprintf("%.4f (%.4f, %.4f)", lgt.spec.num[1], lgt.spec.num[2], lgt.spec.num[3]) 
  sens.ci = sprintf("%.4f (%.4f, %.4f)", plogis(lgt.sens.num[1]), plogis(lgt.sens.num[2]), plogis(lgt.sens.num[3]) )
  spec.ci = sprintf("%.4f (%.4f, %.4f)", plogis(lgt.spec.num[1]), plogis(lgt.spec.num[2]), plogis(lgt.spec.num[3]) ) 

  tau1 <- sqrt(fit.glmm$vcov[1,1])
  tau2 <- sqrt(fit.glmm$vcov[2,2])
  rho  <- fit.glmm$vcov[1,2]/sqrt(fit.glmm$vcov[1,1]*fit.glmm$vcov[2,2])
  par <- c(lsens, lspec, tau1, tau2, rho)
  
  par.df <- data.frame(
    round(SAUC(par),4),
    sens.ci, spec.ci,
    lgt.sens.ci, lgt.spec.ci,
    round(tau1,4), round(tau2,4), round(rho,4)
    )
  colnames(par.df) <- c("SAUC", 
    "Sens (95%CI)", "Spec (95%CI)",
    "logit-Sens (95%CI)", "logit-Spec (95%CI)", 
    "tau1", "tau2", "rho")
  rownames(par.df) <- "Estimates"

return(par.df)
})


output$plot_sroc<-renderPlot({
  
  plot(NULL, 
      xlim = c(0, 1), ylim=c(0,1), 
      lty = 1, 
      xlab=input$sroc.xlab, ylab = input$sroc.ylab) 
  abline(a=0, b=1, lty=2)
  if(input$studypp2) points(1-sp(), se(), pch = 1)

  # if(input$ROCellipse) ROCellipse(data.cc(), 
  #   lty = 2,  level = input$ci.level, correction =0.5, method=input$ci.method, 
  #   pch = 16, add = TRUE)
  
  
  # if(input$Crosshair) crosshair(data.cc(), 
  #   lty = 2, level = input$ci.level, correction =0.5, method=input$ci.method, 
  #   pch = 16,add = TRUE)
curve_sroc<-NULL
curve_sroc_colour<-NULL
curve_sroc_type<-NULL
    if(input$reitmaSROC) {

  fit.reitsma <- fit.reitsma()
      # lines(sroc(fit))
  par <- c(fit.reitsma$coeff[1], -fit.reitsma$coeff[2], sqrt(fit.reitsma$Psi[1,1]), sqrt(fit.reitsma$Psi[2,2]), -fit.reitsma$Psi[1,2]/sqrt(fit.reitsma$Psi[1,1]*fit.reitsma$Psi[2,2]))
  SROC(par, addon=TRUE, add.spoint = input$res.pt, sp.pch = 19,sroc.col=input$colorritma)#"#FF4B00")
  # text(x = 0.8, y = plogis(par[1] - (par[3]*par[4]*par[5]/(par[4]^2)) * (qlogis(0.8) + par[2]))+0.01, labels = "Reitsma model", pos = 2)
#legend("topright", legend = c("reitma"), col = c("#005AFF"), lty = c(1), lwd = 1)
curve_sroc<-c(curve_sroc,"SROC curve by the Reitsma model")
curve_sroc_colour<-c(curve_sroc_colour,input$colorritma)#"#FF4B00")
curve_sroc_type<-c(curve_sroc_type,1)
      if(input$res.ci) {
        cr <- ROCellipse(fit.reitsma)
        lines(cr$ROCellipse, lty = 3,col=input$colorritma)#"#FF4B00")
      }

      # if(input$res.pt) {
      #   cr <- ROCellipse(fit.reitsma)
      #   points(cr$fprsens)
      # }
    }

    if(input$glmmSROC){

      fit.glmm <- GLMMmodel(data())
      par <- c(fit.glmm$coeff[1,1], fit.glmm$coeff[2,1], sqrt(fit.glmm$vcov[1,1]), sqrt(fit.glmm$vcov[2,2]), fit.glmm$vcov[1,2]/sqrt(fit.glmm$vcov[1,1]*fit.glmm$vcov[2,2]))
      SROC(par, addon = TRUE, add.spoint = input$glmm.pt, sp.pch = 19,sroc.col=input$colorglm)#"#005AFF")
  # text(x = 0.6, y = plogis(par[1] - (par[3]*par[4]*par[5]/(par[4]^2)) * (qlogis(0.6) + par[2])), labels = "GLMM", pos = 1)
   curve_sroc<-c(curve_sroc,"SROC curve by the GLM model")
   curve_sroc_colour<-c(curve_sroc_colour,input$colorglm)#"#005AFF")
   curve_sroc_type<-c(curve_sroc_type,1)
# mtext("Explanation", side = 1, line = -2, cex = 0.8)
   if(input$glmm.ci) {

      logit.x <- c(fit.glmm$coeff[1,1], fit.glmm$coeff[2,1])
      se.scale <- c(fit.glmm$coeff[1,2], fit.glmm$coeff[2,2])

      lines(plogis(ellipse(-fit.glmm$vcov[1,2]/sqrt(fit.glmm$vcov[1,1]*fit.glmm$vcov[2,2]),
                          centre = c(-logit.x[2], logit.x[1]),
                          scale = c(se.scale[2], se.scale[1]),
                          level = 0.95)),
        lty=3,col=input$colorglm)#"#005AFF")
    }

      #   if(input$glmm.pt) {
      #   points(1-plogis(par[2]), plogis(par[1]))
      # }
    }

    if(input$mslSROC) {mslSROC(data(), 
    lty = 2,add = TRUE, extrapolate = TRUE, correction = 0.5, correction.control = input$allsingle)
                      curve_sroc<-c(curve_sroc,"SROC curve of MSL")
                      curve_sroc_colour<-c(curve_sroc_colour,"#000000")
                      curve_sroc_type<-c(curve_sroc_type,2)
}
    if (input$rsSROC){ rsSROC(data(), 
    lty= 3,add = TRUE, extrapolate = TRUE, correction = 0.5, correction.control = input$allsingle)
                      curve_sroc<-c(curve_sroc,"SROC curve of RS")
                      curve_sroc_colour<-c(curve_sroc_colour,"#000000")
                      curve_sroc_type<-c(curve_sroc_type,3)
}

    if(length(curve_sroc)>0){
      legend("bottomright", legend =curve_sroc, col =curve_sroc_colour, lty = curve_sroc_type, lwd = 1)
    }

  
})
