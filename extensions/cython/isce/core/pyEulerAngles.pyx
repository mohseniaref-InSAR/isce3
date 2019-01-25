#cython: language_level=3
#
# Author: Bryan V. Riel
# Copyright 2018
#

from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool

from Cartesian cimport cartesian_t, cartmat_t
from EulerAngles cimport EulerAngles
import numpy as np
cimport numpy as np


cdef class pyEulerAngles:
    '''
    Python wrapper for isce::core::EulerAngles

    Args:
        yaw (float): Yaw angle in radians
        pitch (float): Pitch angle in radians
        roll (float): Roll angle in radians
        yaw_orientation (Optional[str]): Can be either 'normal' or 'center'
    '''

    cdef EulerAngles * c_eulerangles
    cdef bool __owner

    def __cinit__(self, double yaw, double pitch, double roll, yaw_orientation='normal'):
        self.c_eulerangles = new EulerAngles(yaw, pitch, roll,
            pyStringToBytes(yaw_orientation))
        self.__owner = True
        
    def __dealloc__(self):
        if self.__owner: 
            del self.c_eulerangles

    def ypr(self):
        '''
        Return yaw, pitch and roll euler angles.

        Returns:
            np.array(3): euler angles
        '''
        cdef cartesian_t _ypr
        _ypr = self.c_eulerangles.ypr()
        res = np.asarray((<double[:3]>(&_ypr[0])).copy())
        return res

    def rotmat(self, sequence):
        '''
        Return rotation matrix corresponding to angle sequence.

        Args:
            sequence (list(3)): Sequence of angles. Example ['y','p','r']

        Returns:
            numpy.array((3,3))
        '''

        cdef cartmat_t Rvec
        cdef string sequence_str = pyStringToBytes(sequence)
        Rvec = self.c_eulerangles.rotmat(sequence_str)
        R = np.empty((3,3), dtype=np.double)
        cdef double[:,:] Rview = R

        for ii in range(3):
            for jj in range(3):
                Rview[ii,jj] = Rvec[ii][jj]
        return R

    def quaternion(self):
        '''
        Return quaternion representation of give euler angles.

        Returns:
            numpy.array(4)
        '''

        cdef vector[double] qvec = self.c_eulerangles.toQuaternionElements()
        res = np.asarray(<double[:4]>(&qvec[0]))
        return res

    @property
    def yaw(self):
        '''
        Return yaw angle in radians.

        Returns:
            float
        '''
        return self.c_eulerangles.yaw()


    @yaw.setter
    def yaw(self, value):
        '''
        Set yaw angle in radians.

        Args:
            value (float): Yaw angle in radians.
        '''
        self.c_eulerangles.yaw(value)

    @property
    def pitch(self):
        '''
        Return pitch angle in radians.

        Returns:
            float
        '''
        return self.c_eulerangles.pitch()


    @pitch.setter
    def pitch(self, value):
        '''
        Set pitch angle in radians.

        Args:
            value (float): Pitch angle in radians.
        '''
        self.c_eulerangles.pitch(value)

    @property
    def roll(self):
        '''
        Return Roll angle in radians.

        Returns:
            float
        '''
        return self.c_eulerangles.roll()

    @roll.setter
    def roll(self, value):
        '''
        Set Roll angle in radians.

        Args:
            value (float): Roll angle in radians.
        '''
        self.c_eulerangles.roll(value)


# end of file