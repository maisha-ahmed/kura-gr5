# pull nginx image
FROM nginx

# update the current version
RUN apt-get update -y

# Install pip and others build tools
RUN apt-get install -y pip python-dev build-essential libssl-dev libffi-dev

# check nginx version
RUN nginx -v

# remove default conf
RUN rm /etc/nginx/conf.d/default.conf
#RUN ls /etc/nginx/conf.d

# create web.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
#RUN ls /etc/nginx/conf.d

# check the configurations file format
RUN nginx -t

#Copy the frontend (backend is inside frontend) files
COPY ./frontend/ /usr/share/nginx/html/
COPY ./backend/ /usr/share/nginx/html/frontend/

EXPOSE 80
