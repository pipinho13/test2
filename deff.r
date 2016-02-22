deff <-
function (model, design) 
{
    for (i in 1:ncol(design)) {
        design[, i] <- as.factor(design[, i])
    }
    design <- as.data.frame(design)
    if (names(design)[1] == "Rep..") {
        design <- design[, 2:ncol(design)]
    }
    for (i in 1:ncol(design)) {
        contrasts(design[, i]) <- "contr.helmert"
    }
    desmat <- model.matrix(model, design)
    desmat2 <- matrix(0, nrow(desmat), ncol(desmat))
    for (i in 1:ncol(desmat)) {
        desmat2[, i] <- desmat[, i]/norm(as.matrix(desmat[, i]), 
            "E")
    }
    ortcon <- desmat[, 2:ncol(desmat)]
    output <- det(crossprod(desmat2))^(1/dim(desmat2)[2])
    list(defficiency = output, ortcon = desmat[, 2:ncol(desmat)], 
        desmat2 = desmat2)
}

