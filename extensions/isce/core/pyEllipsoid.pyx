#cython: language_level=3
#
# Author: Joshua Cohen
# Copyright 2017
#

from libcpp cimport bool
from libcpp.vector cimport vector
from Ellipsoid cimport Ellipsoid

cdef class pyEllipsoid:
    cdef Ellipsoid *c_ellipsoid
    cdef bool __owner

    def __cinit__(self, a=0., e2=0.):
        self.c_ellipsoid = new Ellipsoid(a, e2)
        self.__owner = True
    def __dealloc__(self):
        if self.__owner:
            del self.c_ellipsoid
    @staticmethod
    def bind(pyEllipsoid elp):
        new_elp = pyEllipsoid()
        del new_elp.c_ellipsoid
        new_elp.c_ellipsoid = elp.c_ellipsoid
        new_elp.__owner = False
        return new_elp

    @property
    def a(self):
        return self.c_ellipsoid.a
    @a.setter
    def a(self, double a):
        self.c_ellipsoid.a = a
    @property
    def e2(self):
        return self.c_ellipsoid.e2
    @e2.setter
    def e2(self, double a):
        self.c_ellipsoid.e2 = a
    def copyFrom(self, elp):
        # Replaces copy-constructor functionality
        try:
            self.a = elp.a
            self.e2 = elp.e2
        # Note: this allows for a dummy class object to be passed in that just has a and e2 as 
        # parameters!
        except: 
            print("Error: Object passed in to copy is incompatible with object of type " +
                  "pyEllipsoid.")

    def rEast(self, double a):
        return self.c_ellipsoid.rEast(a)
    def rNorth(self, double a):
        return self.c_ellipsoid.rNorth(a)
    def rDir(self, double a, double b):
        return self.c_ellipsoid.rDir(a,b)
    def latLonToXyz(self, list a, list b):
        cdef vector[double] _a
        cdef vector[double] _b
        for i in range(3):
            _a.push_back(a[i])
            _b.push_back(b[i])
        self.c_ellipsoid.latLonToXyz(_a,_b)
        for i in range(3):
            a[i] = _a[i]
            b[i] = _b[i]
    def xyzToLatLon(self, list a, list b):
        cdef vector[double] _a
        cdef vector[double] _b
        for i in range(3):
            _a.push_back(a[i])
            _b.push_back(b[i])
        self.c_ellipsoid.xyzToLatLon(_a,_b)
        for i in range(3):
            a[i] = _a[i]
            b[i] = _b[i]
    def getAngs(self, list a, list b, list c, d, e=None):
        cdef vector[double] _a
        cdef vector[double] _b
        cdef vector[double] _c
        cdef double _d
        cdef double _e
        if (e):
            print("Error: Python cannot pass primitives by reference.")
            print("To call this function, please pass the function an empty tuple as the fourth")
            print("argument (no fifth argument). The first element of the list will be the azimuth")
            print("angle, the second element will be the look angle.")
            return
        else:
            _d = 0.
            _e = 0.
            for i in range(3):
                _a.push_back(a[i])
                _b.push_back(b[i])
                _c.push_back(c[i])
            self.c_ellipsoid.getAngs(_a,_b,_c,_d,_e)
            for i in range(3):
                a[i] = _a[i]
                b[i] = _b[i]
                c[i] = _c[i]
            d[0] = _d
            d[1] = _e
    def getTCN_TCvec(self, list a, list b, list c, list d):
        cdef vector[double] _a
        cdef vector[double] _b
        cdef vector[double] _c
        cdef vector[double] _d
        for i in range(3):
            _a.push_back(a[i])
            _b.push_back(b[i])
            _c.push_back(c[i])
            _d.push_back(d[i])
        self.c_ellipsoid.getTCN_TCvec(_a,_b,_c,_d)
        for i in range(3):
            a[i] = _a[i]
            b[i] = _b[i]
            c[i] = _c[i]
            d[i] = _d[i]
    def TCNbasis(self, list a, list b, list c, list d, list e):
        cdef vector[double] _a
        cdef vector[double] _b
        cdef vector[double] _c
        cdef vector[double] _d
        cdef vector[double] _e
        for i in range(3):
            _a.push_back(a[i])
            _b.push_back(b[i])
            _c.push_back(c[i])
            _d.push_back(d[i])
            _e.push_back(e[i])
        self.c_ellipsoid.TCNbasis(_a,_b,_c,_d,_e)
        for i in range(3):
            c[i] = _c[i]
            d[i] = _d[i]
            e[i] = _e[i]
