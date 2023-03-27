qsystem.file <- function(...) {paste0("\"", system.file(...), "\"")}
# devtools::install('~/git/adcomp/TMB')
library(TMB)
TMB::compile("ode.cpp",paste0("-I", qsystem.file("include/", package = "BH")))
base::dyn.load(TMB::dynlib("ode"))
data <- list(init = c(10, 5), tmax = 25, dt = 0.1)
init <- list(pars = c(0.5))
obj <- TMB::MakeADFun(data, init, DLL = "ode", silent = TRUE)
rp <- obj$report(obj$env$last.par.best)
array(rp$ode.track, c(3, 250)) %>% 
    t %>% 
    as_tibble() %>% 
    pivot_longer(-V1) %>% 
    ggplot(aes(V1, value, color = name)) +
    geom_line()
