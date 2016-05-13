#!/usr/bin/env python

import openmeeg as om
import numpy as np
from os import path as op

from optparse import OptionParser

data_path = op.dirname(op.abspath(__file__))
parser = OptionParser()
parser.add_option("-p", "--path", dest="data_path",
                  help="path to data folder", metavar="FILE",
                  default=data_path)
options, args = parser.parse_args()
data_path = options.data_path

subject = 'Head1'

cond_file = op.join(data_path,subject,subject+'.cond')
geom_file = op.join(data_path,subject,subject+'.geom')

geom = om.Geometry()
geom.read(geom_file,cond_file)

hm = om.HeadMat(geom,3)

v = hm(1,10,1,1).getcol(0)

vec1 = om.asarray(v)
vec2 = om.asarray(hm(1,10,1,1).getcol(0))


assert(np.linalg.norm(vec1-vec2)<1e-15)
