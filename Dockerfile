FROM swiftdocker/swift:latest

WORKDIR /code

#
# Needed for Zewo
#

# Because need to use add-apt-repository
#RUN apt-get update
#RUN apt-get dist-upgrade -y
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

#RUN add-apt-repository "deb [trusted=yes] http://apt.zewo.io/deb ./"
#RUN apt-key update
#RUN apt-get update
#RUN apt-get -q -y --force-yes install libvenice
#RUN apt-get -q -y --force-yes install http-parser
#RUN apt-get -q -y --force-yes install uri-parser

#
# Needed for Vapor
#
#RUN apt-get update
#RUN apt-get -q -y --force-yes install binutils
