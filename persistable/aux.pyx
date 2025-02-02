# cython: profile=True
# cython: linetrace=True
# cython: boundscheck=False, wraparound=False, cdivision=True

import numpy as np
cimport numpy as np
np.import_array()

DTYPE = np.float64
ctypedef np.float64_t DTYPE_t


def lazy_intersection(np.ndarray[DTYPE_t, ndim=1] increasing, np.ndarray[DTYPE_t, ndim=1] increasing2, np.float64_t s0, np.float64_t k0) :
    # find first occurence of s0 - (s0/k0) * increasing[i]) <= increasing2[i]
    assert increasing.dtype == DTYPE and increasing2.dtype == DTYPE
    cdef np.float64_t mu = s0/k0
    cdef int first = 0
    cdef int last = increasing.shape[0]-1
    cdef int midpoint
    if s0 - mu * increasing[first] <= increasing2[first] :
        return first, False
    if s0 - mu * increasing[last] > increasing2[last] :
        return last, True
    while first+1 < last :
        midpoint = (first + last)//2
        if s0 - mu * increasing[midpoint] <= increasing2[midpoint] :
            last = midpoint
        else:
            first = midpoint
    return last, False