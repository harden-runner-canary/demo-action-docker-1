# Use a lightweight base image with curl installed
FROM alpine:latest

# Install curl
RUN apk add --no-cache curl

# Write a script to make the curl requests, list directory contents, and create the text files
RUN echo '#!/bin/sh' > /script.sh && \
    echo 'echo "Environment Variables:"' >> /script.sh && \
    echo 'env' >> /script.sh && \
    echo 'DOMAINS="google.com youtube.com facebook.com wikipedia.org twitter.com instagram.com linkedin.com pinterest.com whatsapp.com wordpress.com apple.com microsoft.com amazon.com netflix.com adobe.com"' >> /script.sh && \
    echo 'for domain in $DOMAINS; do' >> /script.sh && \
    echo '  echo "Making request to ${domain}"' >> /script.sh && \
    echo '  if curl -m 5 -Is https://$domain; then' >> /script.sh && \
    echo '    echo "Success: Request to ${domain} was successful"' >> /script.sh && \
    echo '  else' >> /script.sh && \
    echo '    echo "Error: Unable to connect to ${domain}"' >> /script.sh && \
    echo '  fi' >> /script.sh && \
    echo 'done' >> /script.sh && \
    echo 'echo "listing content with ls"' >> /script.sh && \
    echo 'ls' >> /script.sh && \
    echo 'echo "hello" > ~/helloworld1.txt' >> /script.sh && \
    echo 'echo "hello" > ~/helloworld2.txt' >> /script.sh && \
    echo 'echo "listing content with ls"' >> /script.sh && \
    echo 'ls ~' >> /script.sh && \
    echo 'echo "sleep for ${SLEEPINSECONDS:-5} seconds"' >> /script.sh && \
    echo 'sleep ${SLEEPINSECONDS:-5}' >> /script.sh && \
    chmod +x /script.sh

# Set the default command for the container to run the script
CMD ["/script.sh"]