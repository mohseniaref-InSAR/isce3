#cython: language_level=3
#
# Author: Bryan V. Riel
# Copyright 2017-2019
#

from Metadata cimport Metadata

cdef class pyMetadata:
    """
    Cython wrapper for isce3::product::Metadata.

    Args:
        None

    Return:
        None
    """
    # C++ class
    cdef Metadata * c_metadata
    cdef bool __owner

    # Cython class members
    cdef pyOrbit py_orbit
    cdef pyAttitude py_attitude
    cdef pyProcessingInformation py_procInfo

    def __cinit__(self):
        """
        Constructor instantiates a C++ object and saves to python.
        """
        # Create the C++ Metadata class
        self.c_metadata = new Metadata()
        self.__owner = True

        # Bind the C++ Orbit class to the Cython pyOrbit instance
        self.py_orbit = pyOrbit()
        self.py_orbit.c_orbit = self.c_metadata.orbit()

        # Bind the C++ Attitude class to the Cython pyAttitude instance
        self.py_attitude = pyAttitude()
        del self.py_attitude.c_attitude
        self.py_attitude.c_attitude = &self.c_metadata.attitude()
        self.py_attitude.__owner = False

        # Bind the C++ ProcessingInformation class to the Cython pyProcessingInformation instance
        self.py_procInfo = pyProcessingInformation()
        del self.py_procInfo.c_procinfo
        self.py_procInfo.c_procinfo = &self.c_metadata.procInfo()
        self.py_procInfo.__owner = False

    def __dealloc__(self):
        if self.__owner:
            del self.c_metadata

    @staticmethod
    def bind(pyMetadata meta):
        """
        Creates a new pyMetadata instance with C++ Metadata attribute shallow copied from
        another C++ Metadata attribute contained in a separate instance.

        Args:
            meta (pyMetadata): External pyMetadata instance to get C++ Metadata from.

        Returns:
            new_meta (pyMetadata): New pyMetadata instance with a shallow copy of C++ Metadata.
        """
        # Bind metadata
        new_meta = pyMetadata()
        del new_meta.c_metadata
        new_meta.c_metadata = meta.c_metadata
        new_meta.__owner = False

        # Bind orbit
        new_meta.py_orbit.c_orbit = meta.c_metadata.orbit()

        # Bind attitude
        new_meta.py_attitude.c_attitude = &meta.c_metadata.attitude()
        new_meta.py_attitude.__owner = False

        # Bind processing info
        new_meta.py_procInfo.c_procinfo = &meta.c_metadata.procInfo()
        new_meta.py_procInfo.__owner = False

        return new_meta

    @property
    def orbit(self):
        """
        Get orbit.
        """
        orbit = pyOrbit()
        orbit.c_orbit = self.py_orbit.c_orbit
        return orbit

    @orbit.setter
    def orbit(self, pyOrbit orb):
        """
        Set orbit.
        """
        self.c_metadata.orbit(orb.c_orbit)

    @property
    def attitude(self):
        """
        Get Euler angles attitude.
        """
        new_attitude = pyAttitude.bind(self.py_attitude)
        return new_attitude

    @attitude.setter
    def attitude(self, pyAttitude attitude):
        """
        Set Euler angles attitude.
        """
        self.c_metadata.attitude(deref(attitude.c_attitude))

    @property
    def procInfo(self):
        """
        Get processing information.
        """
        new_proc = pyProcessingInformation.bind(self.py_procInfo)
        return new_proc

# end of file
