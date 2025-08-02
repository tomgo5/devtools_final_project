# devtools_final_project
Team members: Tom Goldstein 318434198 Alon Rimler 216015016 Tomer Faraj 329455026

>What were we asked to do:

We were asked to create a website using Joomla as the content management system and MySQL as the database. Both Joomla and MySQL had to run inside Docker containers. The tasks included setting up the containers, configuring the site, adding content, backing up the database and site files, restoring the data on another machine, automating the setup and maintenance with scripts, and uploading the full project to GitHub.

>What we did:

    1.Installed Docker and Docker Compose and created a docker-compose.yml file to define the Joomla and MySQL services.

    2.Created and ran the containers using the docker-compose file and ensured that the two services could communicate.

    3.Accessed the Joomla setup through the browser and completed the installation by connecting it to the MySQL database, creating an admin user, and setting the basic configuration.

    4.Added multiple articles to the Joomla website. Each article represented an entry in the Devtools dictionary that we created during our course. (Note: this dictionary was created as part of the course and is referenced here as-is.)

    5.Backed up the database using the mysqldump tool and ensured that Joomla site files (like images and extensions) were saved using Docker volumes.

    6.Verified that the backup could be restored by moving to another Linux machine, copying the backup, and restoring the data into a new MySQL container. Then restarted the Joomla site and confirmed the site was working properly.

    7.Created shell scripts to automate the process:

      setup.sh: starts the Docker containers and sets up the environment.

      backup.sh: creates a backup of the MySQL database.

      restore.sh: restores the database from a backup file and confirms Joomla is working.

      cleanup.sh: removes all containers, volumes, and temporary files to return the system to its original state.

    8.Uploaded the entire project to GitHub, including all configuration files and scripts, and added this README file.

>Technologies used:

Docker
Docker Compose
Joomla
MySQL
mysqldump
Bash scripting
Git and GitHub
Linux shell environment

>Step-by-step guide to restore the website:

    Clone the project repository from GitHub to your local machine.

    Run the setup script to start the Docker containers:

        ./setup.sh

    Open a browser and go to:

        http://localhost

    Follow the Joomla setup wizard:

        Choose the site name

        Set up the administrator account

        Connect Joomla to the MySQL database (usually the host is "db" and the user and password are defined in docker-compose.yml)

    Complete the installation.

    After installation, log into the Joomla admin panel and confirm the articles are available (if restoring from a backup).

    To restore from a previous backup, use the restore script:

        ./restore.sh

This will load the SQL backup into the MySQL container and restart Joomla.

    After checking that everything works, you can clean up the environment with:

        ./cleanup.sh

This will stop and remove the containers, delete volumes and temporary files, and return the system to a clean state.
