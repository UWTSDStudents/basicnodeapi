#### SHARED DOCKER STAGES ##############

# The OS setup
FROM ubuntu as developer-os
MAINTAINER mike <michael.dacey@uwtsd.ac.uk>
ENV DEBIAN_FRONTEND    noninteractive
RUN apt-get update --fix-missing && \
apt-get install -y software-properties-common && \
apt-get install -y --no-install-recommends apt-utils && \
apt-get install -y curl wget
RUN apt-get install -y sudo
RUN echo "export SERVER_IP_ADDRESS='0.0.0.0'" >> /etc/profile
RUN apt-get clean


# Create and change the working directory
WORKDIR /var/www/node
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && \
apt-get install -y nodejs  
RUN apt-get clean

# Copy reqd directories and files into image
COPY . .

# Expose our webservices port number
EXPOSE 80

# Execute the application
ENTRYPOINT ["npm", "run", "start"]


