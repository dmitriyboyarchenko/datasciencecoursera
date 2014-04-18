## This code contains a pair of functions, makeCacheMatrix and cacheSolve,
## the first of which creates a special matrix object that can cache its
## own inverse, while the second one computes the inverse of such a special
## matrix object. If the inverse was cached previously, it is simply
## retrieved from the cache and no additional calculation is performed.

## The function makeCacheMatrix creates a special matrix, which is a list
## consisting of four functions: 1) set the value of the matrix; 2) get
## the value of this matrix; 3) set the value of the inverse of this matrix;
## 4) get the value of the inverse of this matrix

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL # object used to cache the inverse of x
    # The next function is used to modify the matrix, if needed:
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x # retrieves the matrix itself
    setinv <- function(inverse) inv <<- inverse # places the inverse into cache
    getinv <- function() inv # retrieves the inverse from cache
    # The list returned by the function:
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## The function cacheSolve returns the inverse of a special "matrix"
## returned by the function makeCacheMatrix. If the inverse has already
## been cached previously, it is retrived without any additional calculations.

cacheSolve <- function(x, ...) {
        inv <- x$getinv() # attempt to retrieve the inverse from cache
        # If the value retrived is not NULL, we return it
        # (by analogy with the example in the assignment description,
        # we also print a message about retrieving from the cache)
        if (!is.null(inv)) {
            message("Getting cached data")
            return(inv)
        }
        # Otherwise we compute the inverse, cache it for future use,
        # and return it:
        matr <- x$get() # first get the matrix itself
        inv <- solve(matr, ...) # compute the inverse
        x$setinv(inv)
        inv
}
