FROM ibmcom/ace:11.0.0.0

# Set ACE environment variables
ENV LICENSE=accept \
    HOME=/home/aceuser

# Copy Project Interchange to a temporary directory
RUN mkdir -p /tmp/barstore/pi
COPY ace-pi/ /tmp/barstore/pi
RUN sudo chown -R aceuser:aceuser /tmp/barstore/pi

# Package BAR from Project Interchange; need to use bash to make the profile work
RUN bash -c 'mqsipackagebar -a /tmp/barstore/Packaged_Bar.bar -w /tmp/barstore/pi -k TemperatureConverter Transformation_Map BensSimpleRESTAPI'

# Place generated BAR file in correct directory; need to use bash to make the profile work
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/barstore/Packaged_Bar.bar -c'

# Expose default admin port and http ports
EXPOSE 7600 7800 9443
