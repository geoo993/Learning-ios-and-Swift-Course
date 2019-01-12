#!/bin/sh

#  carthage-bootstrap.sh
#  StorySmarties
#
#  Created by Daniel Asher on 29/06/2016.
#  Copyright © 2016 LEXI LABS. All rights reserved.

carthage bootstrap $@ --no-build --no-use-binaries --platform iOS
