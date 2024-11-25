# Use the latest Debian base image
FROM debian:latest

# Set environment variables to avoid prompts during installations
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages including hashcat
RUN apt-get update && \
    apt-get install -y hashcat ttyd && \
    apt-get clean

# Create a start script to run ttyd with hashcat
RUN echo '#!/bin/bash\n\
# Start ttyd and execute hashcat -h within it\n\
ttyd --writable bash -c "hashcat -h; exec bash"' > /start.sh && \
    chmod +x /start.sh

# Expose the port ttyd will run on (default is 7681)
EXPOSE 7681

# Set the start script as the CMD entry point
CMD ["/start.sh"]
